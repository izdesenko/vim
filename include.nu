export alias gdo = git diff -w

export def go [branch?: string, ...rest: string] {
    # 1. Определяем ветку: если $branch не передан, берем текущую из git
    let target_branch = if ($branch | is-empty) {
        git rev-parse --abbrev-ref HEAD | str trim
    } else {
        $branch
    }

    # 2. Собираем остальные аргументы
    # Если $branch не был передан, значит первый аргумент из ...rest на самом деле был частью параметров
    mut args = if ($branch | is-empty) { $rest } else { $rest }

    # 3. Проверяем наличие 'theirs' или 'ours' в оставшихся аргументах
    # Если они есть, добавляем флаг '-X' в начало списка аргументов
    if ($args | any { |it| $it == "theirs" or $it == "ours" }) {
        $args = (['-X'] | append $args)
    }

    # 4. Выполняем финальный git pull
    # Конструкция ...$args правильно распаковывает список элементов в команду
    git pull origin $target_branch ...$args
}

export def gof [] {
	go
	
	git submodule update --init --recursive
	git submodule foreach git checkout master
	git submodule foreach git pull origin master
}

export def work [suffix?: string] {
    # 1. Формируем имя сессии tmux
    let session = if ($suffix | is-empty) {
        "ilya_1"
    } else {
        $"ilya_($suffix)"
    }

    # 2. Ищем, где в системе установлен tmux
    let tmux_bin = (which tmux | get 0?.path? | default "tmux")

    # 3. Пытаемся подключиться к сессии. 
    # Используем try/catch вместо проверки системного кода ошибки "$?"
    try {
        ^$tmux_bin attach -t $session
    } catch {
        # Если при подключении возникла ошибка (сессии нет), проверяем её существование
        # Каретка ^ перед $tmux_bin сообщает Nushell, что мы вызываем внешний бинарник
        let has_session = (run-external $tmux_bin "has-session" "-t" $session o+e>| complete | get exit_code) == 0

        if not $has_session {
            # Если сессии действительно нет, создаем новую в фоне
            run-external $tmux_bin "new-session" "-d" "-s" $session
        }

        # Окончательно подключаемся к созданной или найденной сессии
        ^$tmux_bin attach -t $session
    }
}

# i don't know why does it happen, but in zsh if i just create function gc then git status crashes shell :(
# alias gc="_gc"
export def gc [message?: string] { 
    if ($message | is-empty) { 
        # Вызываем внешний git через каретку, чтобы он мог открыть Emacs/Vim для ввода текста лога
        ^git commit 
    } else { 
        # Используем правильную интерполяцию строк $"... ($переменная) ..."
        git commit -m $"($message)" 
    } 
}

export alias WORK = work
export alias weather = curl wttr.in
export alias weather2 = curl v2.wttr.in
export alias gmerge_no_mess = git merge --no-commit --no-ff 

# Push to current branch to all remotes
export def gop [branch?: string] {
    # 1. Определяем ветку: если $branch пустой, берем текущую
    let target_branch = if ($branch | is-empty) {
        git rev-parse --abbrev-ref HEAD | str trim
    } else {
        $branch
    }

    # 2. Получаем список всех remote-репозиториев в виде списка строк
    # Команда lines разбивает текстовый вывод git на аккуратный массив Nushell
    let remotes = (git remote | lines | str trim)

    # 3. Запускаем цикл по списку репозиториев
    for remote in $remotes {

        # 4. Передаем временную переменную окружения GIT_SSH_COMMAND для конкретной команды push
        # В Nushell переменные окружения внутри 'with-env' пишутся как запись [имя: значение]
        with-env {GIT_SSH_COMMAND: "ssh -o ConnectTimeout=10"} {
            git push $remote $target_branch
        }
    }
}

# Отправка HTML-писем через системную утилиту mail
export def email [to: string, subj: string, body_or_file: string] {
    # 1. Проверяем, является ли третий аргумент существующим файлом
    let email_body = if ($body_or_file | path exists) {
        # Если это файл, читаем его как сырой текст
        open --raw $body_or_file
    } else {
        # Если это не файл, используем сам переданный текст
        $body_or_file
    }

    # 2. Передаем содержимое письма через конвейер во внешнюю утилиту ^mail
    # Каретка ^ нужна, чтобы вызвать системный бинарник /usr/bin/mail
    $email_body | ^mail -a "Content-type: text/html" -s $subj $to

    print "SENT"
}

# Проверить, какой процесс занял указанный порт
export def who_uses_port [port: any] {
    # 1. Проверяем операционную систему через встроенную системную переменную
    let port_str = ($port | into string)
    if $nu.os-info.name == "macos" {
        # Используем внешние утилиты ^lsof и ^grep через каретку
        ^lsof -n $"-i4TCP:($port_str)" | ^grep LISTEN
    } else {
        # Если это Linux или любая другая ОС
        ^netstat -tulpn | ^grep $port
    }
}

# Показать подробную историю слоев Docker-образа
export def docker_log [image: string] {
    # 1. Получаем историю слоев. Флаг --format json заставляет docker выдать валидный JSON.
    # Команда 'from json -o' превращает этот JSON в аккуратную таблицу Nushell.
    let history = (docker history $image --format json | from json -o)

    # 2. Запускаем цикл по строкам таблицы
    for row in $history {
        # Если у слоя нет ID (например, это пропущенный слой во время сборки), пропускаем его
        if ($row.ID == "<missing>") { continue }

        # 3. Вызываем docker inspect сразу в формате JSON и забираем нужные поля напрямую!
        let inspect = (docker inspect $row.ID | from json | get 0)
        
        let created = $inspect.Created
        let author  = ($inspect.Author? | default "N/A")
        let comment = ($inspect.Comment? | default "N/A")

        # 4. Выводим результат в красивом структурированном виде
        print $"($row.ID) Created: ($created) | Author: ($author) | Comment: ($comment)"
    }
}

export def timestamp [] { date now | into int }

export alias less = less -S --shift 5
export alias mtail = less +F 
export alias grep = grep --color=always --exclude='*.swp' --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=log --exclude-dir=tmp
export alias ll = ls -a
export alias gis = git -c color.ui=always -c color.status=always status
export alias GIS = git -c color.ui=always -c color.status=always status
export alias пшы = git -c color.ui=always -c color.status=always status
export alias giss = zsh -ci 'git -c color.ui=always -c color.status=always status | grep -v .min.js | grep -v .min.css'
export alias gil = git log --stat --graph --pretty=short --abbrev-commit
export alias ga = git add 
export alias gai = ga -i
export alias gchp = git checkout -p
export alias gc = git commit --author="Ilya<iplugin@gmail.com>" -m 
export alias gca = git commit --amend 
export alias gd = git diff HEAD 
export alias gab = zsh -ci "git ls-remote | perl -ne '/\/([^\/]+\$)/; print \$1"
export alias gfo = git fetch origin
export alias gwl = git worktree list
export alias vim = vim -p
# export alias view = view -p
export alias control = zsh -ci 'cd ~/control/; emacs  time.txt plan.txt consience.txt ideas.txt bot.txt'
export alias VIM = vim
export alias free_space = df . -h
export alias myptidy = perltidy -opt -ce -bar -bt=2 -pt=2 -bbt=2 -sbt=2 -dws -cti=1 
# export alias timestamp = into int (date now)
export alias download = curl -L --progress-bar --fail -O 
export alias used_ports = lsof -i
export alias used_ports2 = netstat -tulpn
export alias lynx = lynx -accept_all_cookies

# Генерация случайной строки заданной длины (по умолчанию 100 символов)
export def my_random [length: int = 100] {
    # 1. Задаем набор разрешенных символов (ваш список)
    let chars = "\\/,.!@#$%^*{}[];:|~&()a-zA-Z0-9_+-"

    # 2. Генерируем с запасом случайные байты, декодируем в текст и фильтруем через регулярное выражение
    # Переменная length задает, сколько символов оставить в конце
    random chars --length $length
}

export def perl-draft [filename: string] {
    if not ( $filename | path exists ) {
        let template = [
            "#!/usr/bin/env perl"
            ""
            "use utf8;"
            "use strict;"
            "use warnings;"
            "use Data::Dumper;"
            "use feature 'say';"
            ""
            "binmode $_, ':encoding(utf-8)' for *STDIN, *STDOUT, *STDERR;"
            ""
            ""
            ""
            ""
            "__DATA__"
        ] | str join "\n"
        
        $template | save $filename
    }

    run-external $env.EDITOR $filename # Сразу открывает созданный файл в VS Code
}

export def --env mclaude [] {
    with-env { CLAUDE_CODE_MAX_OUTPUT_TOKENS: "8192" } {
        claude
    }
}

export def --env mc [...args] {
    # Запрашиваем тему. Направляем и вывод, и ошибки (o+e>) в системный /dev/null
    let is_dark = (try { 
        ^defaults read -g AppleInterfaceStyle e> /dev/null | str trim 
    } catch { 
        "Light" 
    })
    
    # Выбираем скин
    let skin = (if $is_dark == "Dark" { "nicedark" } else { "gray-green-purple256" })
    let expanded_args = ($args | each { |it| $it | path expand })
    
    # Запускаем Midnight Commander
    with-env { MC_SKIN: $skin } { ^mc ...$expanded_args }    
}

export def optimize_images [
    mask: glob               # *.jpg или *.png, ./**/*.jpg
    size: int = 1000         # Optional: Optimized image min side new size (default 1000px)
    quality: int = 70        # Optional: Optimized image quality (default 70%)
] {
    # Создаем папку для оптимизированных изображений, если её еще нет
    mkdir optimized

    # Находим файлы по маске и запускаем обработку
    glob $mask | each { |file|
        # Формируем имя выходного файла внутри папки optimized
        let out = $"optimized/($file | path basename)"
        
        # Строим геометрию для ImageMagick
        let resize_param = $"($size)x($size)^>"
        
        # Выводим в консоль информацию о процессе (по желанию можно убрать)
        print $"Оптимизация ($file) -> ($out)..."
        
        # Выполняем команду magick
        magick $file -resize $resize_param -strip -quality $quality $out
    }
    print "🎉 Оптимизация успешно завершена! Все файлы сохранены в папку 'optimized'."
}

export def gdw [...args: string] {
    git diff -U10 --minimal ...$args 
    | dwdiff --diff-input -c 
    | less -R
}
