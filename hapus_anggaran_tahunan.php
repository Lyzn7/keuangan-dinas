<?php
session_start();
include 'koneksi.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($id) {
    $stmt = $k->prepare("DELETE FROM anggaran_tahunan WHERE id = ?");
    $stmt->bind_param("i", $id);
    $ok = $stmt->execute();
    $stmt->close();

    $_SESSION['flash_msg'] = $ok ? "Anggaran tahunan dihapus." : "Gagal menghapus anggaran tahunan.";
} else {
    $_SESSION['flash_msg'] = "ID anggaran tahunan tidak valid.";
}

header("Location: histori.php");
exit;
