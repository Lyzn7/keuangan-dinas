<?php
$host = getenv('DB_HOST') ?: 'localhost';
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: '';
$db   = getenv('DB_NAME') ?: 'monitor_keuangan';
$port = getenv('DB_PORT') ?: 3306;

$k = new mysqli($host, $user, $pass, $db, $port);

if ($k->connect_error) {
    die("DB fail: " . $k->connect_error);
}
?>
