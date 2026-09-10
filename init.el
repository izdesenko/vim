;(setq indent-line-function 'insert-tab)

(package-initialize)
;; store all backup and autosave files in the tmp dir
;; Прокидываем стандартные пути macOS для внешних утилит (git, clang, make)
(setq exec-path (append '("/usr/bin" "/usr/local/bin" "/opt/homebrew/bin") exec-path))
(setenv "PATH" (concat "/usr/bin:/usr/local/bin:/opt/homebrew/bin:" (getenv "PATH")))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq vc-follow-symlinks nil)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq-default tab-width 4)

(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)
    (setq-default scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

(add-to-list 'auto-mode-alist '("\\.\\(t\\)\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.\\(tt\\)\\'" . sgml-mode))
(defalias 'perl-mode 'cperl-mode)

(add-to-list 'load-path "~/.emacs.d/stuff")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;--;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;;--;; and `package-pinned-packages`. Most users will not need or want to do this.
;;--;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;--(package-initialize)
;;--(custom-set-variables
;;-- ;; custom-set-variables was added by Custom.
;;-- ;; If you edit it by hand, you could mess it up, so be careful.
;;-- ;; Your init file should contain only one such instance.
;;-- ;; If there is more than one, they won't work right.
;;-- '(package-selected-packages '(iedit)))
;;--(custom-set-faces
;;-- ;; custom-set-faces was added by Custom.
;;-- ;; If you edit it by hand, you could mess it up, so be careful.
;;-- ;; Your init file should contain only one such instance.
;;-- ;; If there is more than one, they won't work right.
;;-- )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(cperl-auto-newline nil)
 '(cperl-auto-newline-after-colon nil)
 '(cperl-autoindent-on-semi nil)
 '(find-file-suppress-same-file-warnings t)
 '(grep-command "grep -rl ")
 '(grep-find-ignored-directories
   '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN"
     "_darcs" "{arch}" "node_modules" "tmp" "*.swp" "log"))
 '(grep-find-ignored-files
   '(".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg"
     "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm"
     "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl"
     "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl"
     "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl"
     "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl"
     "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp"
     "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys"
     "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo" "*.swp"))
 '(grep-search-path '(nil "~/"))
 '(indent-tabs-mode nil)
 '(mouse-wheel-scroll-amount '(1 ((shift) . 1) ((meta)) ((control) . text-scale)))
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((lsp-biome :vc-backend Git :url
                "https://github.com/cxa/lsp-biome.git")))
 '(read-buffer-completion-ignore-case t)
 '(read-file-name-completion-ignore-case t)
 '(scroll-conservatively 10000)
 '(show-paren-mode t)
 '(tab-width 4)
 '(truncate-lines t)
 '(uniquify-buffer-name-style 'forward nil (uniquify))
 '(uniquify-min-dir-content 2)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)

(defun create-tags()
  "Create tags file."
  (eshell-command 
   (format "find . -type f -regex '.*\\(p[ml]\\|js\\)$' -not -path './.git/*' -not -path './.vim/*' -not -path './.emacs.d/*' -not -path '*/node_modules/*' -not -path '*/thirdparty/*' | xargs etags --append")))
(put 'set-goal-column 'disabled nil)

(global-set-key (kbd "C-;") nil)
(global-set-key (kbd "C-\\") nil)
(global-set-key (kbd "<C-left>") nil)
(global-set-key (kbd "<C-right>") nil)

(global-set-key (kbd "C-\\") 'er/expand-region)
(global-set-key (kbd "C-M-i") 'iedit-mode)
(global-set-key (kbd "<C-left>") 'backward-sexp)
(global-set-key (kbd "<C-right>") 'forward-sexp)

(put 'narrow-to-region 'disabled nil)

;; Отключаем передачу координат мыши из терминала в Emacs
(unless (display-graphic-p)
  (xterm-mouse-mode -1)
  (track-mouse nil))

; Возможно, это фикм для проблем с неадекватным курсором
;(setq tty-focus-mode nil) ; Полностью отключает отслеживание фокуса терминалом, если оно мешает

;; Принудительно отключаем BIDI для всех буферов
(setq-default bidi-display-reordering nil)
(setq-default bidi-paragraph-direction 'left-to-right)

;; Включаем продвинутый cperl-mode вместо стандартного perl-mode
(defalias 'perl-mode 'cperl-mode)

;; Настраиваем cperl-mode для корректных отступов (4 пробела)
(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
      cperl-indent-parens-as-block t)

;; Регистрируем perlnavigator в клиенте eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `((cperl-mode perl-mode) . ("perlnavigator" "--stdio"))))

;; Автоматически запускаем eglot при открытии Perl-файлов
(add-hook 'cperl-mode-hook 'eglot-ensure)

(use-package nushell-mode
  :ensure t
  :mode "\\.nu\\'")

;; 1. Безопасная проверка и установка Biome из репозитория
(unless (featurep 'lsp-biome)
  (when (and (fboundp 'package-vc-install) 
             (not (package-installed-p 'lsp-biome)))
    (package-vc-install "https://github.com/cxa/lsp-biome.git")))

;; =============================================================================
;; 1. КАРТА РЕПОЗИТОРИЕВ TREE-SITTER (Для подсветки кода)
;; =============================================================================
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src")
        (js "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (html "https://github.com/tree-sitter/tree-sitter-html" "master" "src")
        (css "https://github.com/tree-sitter/tree-sitter-css" "master" "src")))

;; =============================================================================
;; 2. НАСТРОЙКА РЕЖИМА TYPESCRIPT (Tree-sitter версия)
;; =============================================================================
(use-package typescript-ts-mode
  :ensure nil ; Встроено в Emacs 29+
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))

;; =============================================================================
;; 3. ИНТЕГРАЦИЯ BIOME (Форматирование, сортировка и линтинг при сохранении)
;; =============================================================================
(defun my/biome-format-and-fix-buffer ()
  "Автоматически запускает проверку и исправление Biome СТРОГО ПОСЛЕ сохранения файла на диск."
  (when (derived-mode-p 'typescript-ts-mode 'tsx-ts-mode 'web-mode 'js-mode 'json-mode)
    (let* ((file-path (buffer-file-name))
           (project-root (and file-path (locate-dominating-file file-path "package.json")))
           (local-biome (and project-root (expand-file-name "node_modules/.bin/biome" project-root)))
           (biome-exec (if (and local-biome (file-executable-p local-biome))
                           local-biome
                         (executable-find "biome"))))
      
      (when (and file-path biome-exec)
        ;; Временно отключаем хук, чтобы команда revert-buffer не вызвала бесконечный цикл сохранения
        (remove-hook 'after-save-hook #'my/biome-format-and-fix-buffer)
        (let ((inhibit-message t))
          ;; Запускаем Biome поверх уже сохраненного на диск чистого файла
          (call-process biome-exec nil nil nil "check" "--write" "--unsafe" file-path)
          ;; Обновляем буфер в Emacs, чтобы увидеть результат
          (revert-buffer t t t))
        ;; Возвращаем хук на место для следующих сохранений
        (add-hook 'after-save-hook #'my/biome-format-and-fix-buffer)))))

;; 🎯 ВАЖНО: Удаляем старый хук BEFORE и вешаем на чистый AFTER
(remove-hook 'before-save-hook #'my/biome-format-and-fix-buffer)
(add-hook 'after-save-hook #'my/biome-format-and-fix-buffer)

;; Включаем сохранение истории минибуфера
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)

;; Дополнительно настраиваем историю
(setq history-length 1000)        ;; Сколько записей хранить в истории
(setq history-delete-duplicates t) ;; Удалять дубликаты из истории
