<?php
session_start();
include 'koneksi.php';

$id    = isset($_POST['id_anggaran']) ? (int)$_POST['id_anggaran'] : 0;
$rek   = isset($_POST['id_rekening']) ? (int)$_POST['id_rekening'] : 0;
$tahun = isset($_POST['tahun']) ? (int)$_POST['tahun'] : 0;
$bulan = isset($_POST['bulan']) ? (int)$_POST['bulan'] : 0;
$jenis = $_POST['jenis'] ?? 'murni';
$nilai = isset($_POST['nilai_bulanan']) ? (float)$_POST['nilai_bulanan'] : 0;

if (!$id || !$rek || !$tahun || !$bulan) {
    $_SESSION['flash_msg'] = "Input tidak lengkap.";
    header("Location: form_edit_anggaran.php?id=$id");
    exit;
}

$cekRek = $k->query("SELECT is_active FROM rekening WHERE id_rekening=$rek");
if (!$cekRek || $cekRek->fetch_assoc()['is_active'] != 1) {
    $_SESSION['flash_msg'] = "Rekening tidak aktif.";
    header("Location: form_edit_anggaran.php?id=$id");
    exit;
}

if ($nilai < 0) {
    $_SESSION['flash_msg'] = "Nilai tidak boleh kurang dari 0!";
    header("Location: form_edit_anggaran.php?id=".$id);
    exit;
}

$k->query("
    UPDATE anggaran SET
        id_rekening='$rek',
        tahun='$tahun',
        bulan='$bulan',
        jenis='$jenis',
        nilai_bulanan='$nilai'
    WHERE id_anggaran='$id'
");

$_SESSION['flash_msg'] = "Perubahan anggaran bulanan berhasil disimpan!";
header("Location: histori.php");
