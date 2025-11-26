<?php
$host = getenv('DB_HOST') ?: 'maglev.proxy.rlwy.net';
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$user = getenv('DB_USER') ?: 'root';
$pass = getenv('DB_PASS') ?: 'qKHVsZjpnrmMKuKeDFujKcEnbnuEnXMk';
$db   = getenv('DB_NAME') ?: 'railway';
$port = getenv('DB_PORT') ?: 26932;

$k = new mysqli($host, $user, $pass, $db, $port);

if ($k->connect_error) {
    die("DB fail: " . $k->connect_error);
}
?>
