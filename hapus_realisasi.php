<?php
session_start();
include 'koneksi.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($id) {
    $stmt = $k->prepare("DELETE FROM realisasi_detail WHERE id_detail = ?");
    $stmt->bind_param("i", $id);
    $ok = $stmt->execute();
    $stmt->close();

    $_SESSION['flash_msg'] = $ok ? "Realisasi dihapus." : "Gagal menghapus realisasi.";
} else {
    $_SESSION['flash_msg'] = "ID realisasi tidak valid.";
}

header("Location: histori.php");
exit;
