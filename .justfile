set dotenv-load
docker_php_exec := "docker compose exec -it php"
composer := docker_php_exec + " composer "

up:
    docker compose pull
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

tests format='--testdox':
    {{docker_php_exec}} php vendor/bin/phpunit {{format}}

#tests_xdebug:
tests_xdebug:
    {{docker_php_exec}} env XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003" PHP_IDE_CONFIG="serverName=mydocker" php vendor/bin/phpunit

tests_watch:
    #!/usr/bin/env sh
    if ! command -v entr >/dev/null 2>&1; then
        echo "Error: entr is not installed. Please install it first."
        exit 1
    fi
    find src -name \*\.php | entr -n sh -c 'docker compose exec -T -u dev --env XDEBUG_MODE=debug --env XDEBUG_SESSION=1 --env XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003"  --env PHP_IDE_CONFIG="serverName=mydocker" php vendor/bin/phpunit'

run_xdebug:
    {{docker_php_exec}} env XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003" PHP_IDE_CONFIG="serverName=mydocker" php index.php

# interactive php shell
psysh:
    {{docker_php_exec}} psysh

phpstan:
    {{docker_php_exec}} phpstan analyse src --level max

cs-fix:
    {{docker_php_exec}} php-cs-fixer fix src

rector:
    {{docker_php_exec}} vendor/bin/rector

# csfix + rector + phpstan + phpunit
lint: cs-fix rector phpstan tests

# firt run docker compose up + composer install + open browser
[private]
init:
    docker compose down
    just up
    {{composer}} install
