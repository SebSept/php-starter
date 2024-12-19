<?php
declare(strict_types=1);

namespace App;

class Hello
{
    public function __invoke(): void
    {
        echo 'Hello. Write in ' . __FILE__;
    }

    public function hello(): string
    {
        return 'hello';
    }
}

