docker_php_exec := "docker compose exec -it php"
composer := docker_php_exec + " composer "

up:
    docker pull
    docker compose up --detach --remove-orphans --build

# update source files + docker compose down+up
update: && tests
    git pull
    docker compose down
    docker compose up -d --build
    {{composer}} install

# open a fish shell on the container
fish:
    {{docker_php_exec}} fish

# phpunit tests
tests format='--testdox':
    {{docker_php_exec}} php vendor/bin/phpunit {{format}}

# watch src then run tests
tests_watch:
    find src -name \*\.php | entr just tests

# tests_xdebug:
tests_xdebug:
    {{docker_php_exec}} env XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003" PHP_IDE_CONFIG="serverName=myrepl" php vendor/bin/phpunit

# interactive php shell
psysh:
    {{docker_php_exec}} psysh

# firt run docker compose up + composer install + open browser
[private]
init:
    docker compose down
    just up
    {{composer}} install
