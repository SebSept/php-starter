<?php

namespace App\Tests;

use App\Hello;
use PHPUnit\Framework\TestCase;

class HelloTest extends TestCase
{

    public function testHello(): void
    {
        $hello = new Hello();
        $this->assertSame('hello', $hello->hello());
    }
}
