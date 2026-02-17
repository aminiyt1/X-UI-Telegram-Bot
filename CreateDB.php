<?php

require_once 'config.php';

$connection = new mysqli($dbHost, $dbUser, $dbPass, $dbName);

if ($connection->connect_error) {
    exit("اتصال ناموفق: " . $connection->connect_error);
}

$connection->set_charset("utf8mb4");

// ────────────────────────────────────────────────
// جدول panels
// ────────────────────────────────────────────────
$connection->query("
    CREATE TABLE IF NOT EXISTS `panels` (
        `id`       INT(11)      NOT NULL AUTO_INCREMENT,
        `name`     VARCHAR(255) NOT NULL,
        `url`      VARCHAR(255) NOT NULL,
        `username` VARCHAR(255) NOT NULL,
        `password` VARCHAR(255) NOT NULL,
        `cookie`   TEXT         DEFAULT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
");

// ────────────────────────────────────────────────
// جدول settings
// ────────────────────────────────────────────────
$connection->query("
    CREATE TABLE IF NOT EXISTS `settings` (
        `key_name` VARCHAR(50) NOT NULL,
        `value`    TEXT        DEFAULT NULL,
        PRIMARY KEY (`key_name`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
");

$connection->query("
    INSERT IGNORE INTO `settings` (`key_name`, `value`)
    VALUES ('support_id', 'Admin')
");

// ────────────────────────────────────────────────
// جدول users
// ────────────────────────────────────────────────
$connection->query("
    CREATE TABLE IF NOT EXISTS `users` (
        `chat_id` BIGINT(20)     NOT NULL,
        `step`    VARCHAR(50)    DEFAULT 'none',
        `data`    VARCHAR(255)   DEFAULT NULL,
        PRIMARY KEY (`chat_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
");


$connection->close();
?>