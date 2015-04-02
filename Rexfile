use Data::Dumper;
my $conf = do './.conf';

user $conf->{user};
private_key $conf->{private_key};
public_key  $conf->{public_key};
key_auth;

use POSIX 'strftime';

############## До выяснениня обстоятельст это - боевой конфиг Rex
# конфиг для системы удаленного выполнения задач Rex
# позволяет удаленно осуществлять слив кода на тестовый сервер
# при отсутствии конфликтов в рабочих копиях RC и master
# релиз можно сделать несколькими командами 
#
# rex status     - git status на боевых серверах
# rex fetch      - git fetch origin на боевых серверах
# rex checkpoint - сохранить номер ревизии в которой находится рабочая копия на данный момент (чтобы потом откатиться, в случае возникновения проблем.)
# rex release    - git pull origin master на боевых сервеорах
# rex run        - ./bin/hypnorestart.sh на боевых сервеорах
# rex rollback   - Считать номер ревизии на момент старта релиза и откатиться, если возникли проблемы

group 'production' => @{$conf->{'groups'}->{'production'}->{'ips'}};
group 'test' => @{$conf->{'groups'}->{'test'}->{'ips'}};

my $CD = "cd $conf->{'groups'}->{'production'}->{'root'};";

desc "git status на боевых серверах";
task "status", group => "production", sub {
	local $, = "\n";
	say run $CD."git status";
};

desc "git fetch origin на боевых серверах чтобы ускорить в дальнейшем обновление.";
task "fetch", group => "production", sub {
	local $, = "\n";
	say run $CD."git fetch origin";
};

desc 'Set "Check Point" - store last commit to rollback if problems will arrive.';
task "checkpoint", group => "production", sub {
	local $, = "\n";
	
	my ($now, $dayly, $monthly) = map {".last_commit.".strftime($_, localtime)} qw/%Y-%m-%d.%H:%M %Y-%m-%d %Y-%m/;
	
	say run $CD." git log --name-status HEAD^..HEAD > $now"     unless run $CD." [ -e $now ] && echo \"Found\"";
	say run $CD." git log --name-status HEAD^..HEAD > $dayly"   unless run $CD." [ -e $dayly ] && echo \"Found\"";
	say run $CD." git log --name-status HEAD^..HEAD > $monthly" unless run $CD." [ -e $monthly ] && echo \"Found\"";
};

desc "Релиз на боевых серверах. git pull origin master";
task "release", group => "production", sub {
	local $, = "\n";
	say run $CD."git pull origin master;";
};

desc "Запуск на боевых серверах. ./bin/hypnorestart.sh";
task "run", group => "production", sub {
	local $, = "\n";
	say run $CD."./bin/hypnoreload.sh";
};

desc "НЕ РАБОТАЕТ!!!! Откатываемся на боевых серверах. Из .last_commit.YYYY-mm-dd берем номер ревизии, в которой была раб.копия на момент неудачного release'а. И делаем git checkout <revision>";
task "rollback", group => "production", sub {
	local $, = "\n";
	
	my @lt = localtime;
	my $c = run $CD." cat .last_commit.".strftime('%Y-%m-%d', @lt);
	
	($c)  = ($c =~ /commit\s+([^\n]+)/);
	if ($c) {
		say run $CD." git checkout $c;";
		say run $CD."./bin/hypnorestart.sh";
	}
};

task "rollback_test", group => "production", sub {
	local $, = "\n";
	
	my @lt = localtime;
	$lt[3] += 10;
	my $c;
	
	until ($c) {
		my $fn = ".last_commit.".strftime('%Y-%m-%d', @lt);
		print "$fn\n";
		$c = run $CD." cat $fn" if run "-z $fn";
		$lt[3]--;
	}
	
	($c)  = ($c =~ /commit\s+([^\n]+)/);
	print "$c\n";
	# if ($c) {
	# say run $CD." git checkout $c;";
	# say run $CD."./bin/hypnorestart.sh";
	# }
};

desc 'Hard release - merge master with RC without pushing to origin to be able to roll back all changes';
task 'hard_release', 'group' => 'production', sub {
	local $, = "\n";
	
	say run $CD."git pull origin RC;";
};

desc 'Hard rollback of hard release. Run git reset --hard origin/master to get off bad merge';
task 'hard_rollback', 'group' => 'production', sub {
	local $, = "\n";
	
	say run $CD."git reset --hard origin/master;";
};

desc 'Get rid of .last_commit**** files';
task 'flush', group => 'production', sub {
	local $, = "\n";
	
	my @names = split /\s+/, run $CD.'echo .last_commit*';
	print Dumper(\@names);
};

