<?php
session_start();
include 'koneksi.php';

$id      = isset($_POST['id_detail']) ? (int)$_POST['id_detail'] : 0;
$rek     = isset($_POST['id_rekening']) ? (int)$_POST['id_rekening'] : 0;
$tahun   = isset($_POST['tahun']) ? (int)$_POST['tahun'] : 0;
$bulan   = isset($_POST['bulan']) ? (int)$_POST['bulan'] : 0;
$tanggal = $_POST['tanggal'] ?? null;
$jumlah  = isset($_POST['jumlah_realisasi']) ? (float)$_POST['jumlah_realisasi'] : 0;

if (!$id || !$rek || !$tahun || !$bulan) {
    $_SESSION['flash_msg'] = "Input tidak lengkap.";
    header("Location: form_edit_realisasi.php?id=$id");
    exit;
}

if ($jumlah < 0) {
    $_SESSION['flash_msg'] = "Jumlah realisasi tidak boleh kurang dari 0!";
    header("Location: form_edit_realisasi.php?id=".$id);
    exit;
}

$k->query("
    UPDATE realisasi_detail SET
        id_rekening='$rek',
        tahun='$tahun',
        bulan='$bulan',
        tanggal='$tanggal',
        jumlah_realisasi='$jumlah'
    WHERE id_detail='$id'
");

$_SESSION['flash_msg'] = "Realisasi berhasil diperbarui!";
header("Location: histori.php");
