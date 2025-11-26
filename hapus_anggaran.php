<?php
session_start();
include 'koneksi.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($id) {
    $stmt = $k->prepare("DELETE FROM anggaran WHERE id_anggaran = ?");
    $stmt->bind_param("i", $id);
    $ok = $stmt->execute();
    $stmt->close();

    $_SESSION['flash_msg'] = $ok ? "Anggaran bulanan dihapus." : "Gagal menghapus anggaran.";
} else {
    $_SESSION['flash_msg'] = "ID anggaran tidak valid.";
}

header("Location: histori.php");
exit;
