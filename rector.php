<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\PHPUnit\Set\PHPUnitSetList;

return RectorConfig::configure()
    ->withPaths([
        __DIR__ . '/src',
        __DIR__ . '/tests',
        __DIR__ . '/rector.php',
    ])
    ->withSkipPath(__DIR__ . '/vendor')
    ->withImportNames(removeUnusedImports: true)
    ->withPhpSets(php83: true)
    ->withSets([
        PHPUnitSetList::PHPUNIT_CODE_QUALITY,
    ])
    ->withRules([])
    ->withPreparedSets(
        deadCode: true,
        codeQuality: true,
        codingStyle: true,
        typeDeclarations: true,
        privatization: true,
        naming: true,
        instanceOf: true,
        earlyReturn: true,
        strictBooleans: true
    )
    ->withParallel();
