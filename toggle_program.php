<?php
session_start();
include 'koneksi.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if (!$id) {
    $_SESSION['flash_msg'] = "ID program tidak valid.";
    header("Location: manajemen_program.php");
    exit;
}

$res = $k->query("SELECT is_active FROM program WHERE id_program = $id");
if (!$res || $res->num_rows == 0) {
    $_SESSION['flash_msg'] = "Program tidak ditemukan.";
    header("Location: manajemen_program.php");
    exit;
}

$current = (int)$res->fetch_row()[0];
$new = $current ? 0 : 1;

$k->query("UPDATE program SET is_active = $new WHERE id_program = $id");

$_SESSION['flash_msg'] = $new ? "Program diaktifkan" : "Program dinonaktifkan";

header("Location: manajemen_program.php");
exit;
