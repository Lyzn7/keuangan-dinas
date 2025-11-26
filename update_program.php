<?php
session_start();
include 'koneksi.php';

$id     = isset($_POST['id_program']) ? (int)$_POST['id_program'] : 0;
$kode   = $k->real_escape_string($_POST['kode'] ?? '');
$nama   = $k->real_escape_string($_POST['nama'] ?? '');
$active = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 1;

if (!$id || $kode === '' || $nama === '') {
    $_SESSION['flash_msg'] = "Input tidak lengkap.";
    header("Location: form_edit_program.php?id=$id");
    exit;
}

$cek = $k->query("
    SELECT id_program FROM program 
    WHERE (kode_program='$kode' OR nama_program='$nama')
      AND id_program <> $id
    LIMIT 1
");

if ($cek->num_rows > 0) {
    $_SESSION['flash_msg'] = "Gagal! Kode atau nama program sudah digunakan.";
    header("Location: form_edit_program.php?id=$id");
    exit;
}

$q = $k->query("
    UPDATE program SET 
        kode_program='$kode',
        nama_program='$nama',
        is_active=$active
    WHERE id_program=$id
");

$_SESSION['flash_msg'] = $q 
    ? "Program berhasil diperbarui."
    : "Gagal update: " . $k->error;

header("Location: manajemen_program.php");
exit;
