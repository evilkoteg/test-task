<?php

require 'vendor/autoload.php';

$config = [
    'settings' => [
        'displayErrorDetails' => true,
    ],
];
$app = new \Slim\App($config);

require 'src/autoload.php';

$app->run();

?>
