! This repository is at an early stage of development.
I use it to fast start my own projects/tests.  

---
# PHP / Docker / Composer Project Bedrock

Ready to use repository for any symfony project.
This provides a Docker image and files to bootstrap a Symfony project.

## Motivation

Avoid doing always the same things when starting a composer project.
Learn Docker, php server admin.

## Features

- docker php image based on php-fpm (alpine linux)
  - xdebug, intl, pdo_pgsql
  - composer
  - fish shell
  - symfony cli
  - psysh
- just file for just task runner

### Justfile

Shortcuts to run commands in the container using [just task runner](https://github.com/casey/just) 
in `.justfile`  to help with common tasks.

- up # docker-compose up -d
- update # update source files + docker compose down+up + tests
- fish # open a fish shell on the container
- new-controller
- new-api # new api controller + migrations
- db-create # drop and recreates the db (for dev)
- db-migrate # doctrine:migrations:migrate --no-interaction
- db-create-test # create test db
- db-fixtures-make # create fixtures in dev db
- make:fixtures
- db-fixtures-load
- console # run a symfony console
- req package # composer req
- req-dev package
- tests # run phpunit tests
- test # run a single test
- make-test
- sql # run sql command using {{console}} dbal:run-sql
- psysh

## Requirements

- _docker compose_
- [just task runner](https://github.com/casey/just)
- _xdg-open_ for `init` command (type `xdg-open` in your terminal to test)

## Getting started

Check requirements above. 

- Click the _Use this template_ green button on top of this page (github).
- Clone your new repository
- Adjust the `.env` file if needed
- Adjust `composer.json` file
- In your terminal : `just init` (or `just init-alt` if _xdg-open_ not available)

Done ! Ready to dev.
