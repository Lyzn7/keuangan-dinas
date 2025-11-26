<?php
include 'koneksi.php';

$id_program = isset($_POST['id_program']) ? (int)$_POST['id_program'] : 0;
$kode       = trim($_POST['kode'] ?? '');
$nama       = trim($_POST['nama'] ?? '');
$is_active  = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 1;

if (!$id_program || $kode === '' || $nama === '') {
    echo "<script>alert('Input tidak lengkap.'); window.history.back();</script>";
    exit;
}

$kode = $k->real_escape_string($kode);
$nama = $k->real_escape_string($nama);

$cek = $k->query("
    SELECT id_kegiatan FROM kegiatan 
    WHERE id_program=$id_program 
      AND (kode_kegiatan='$kode' OR nama_kegiatan='$nama')
    LIMIT 1
");

if ($cek->num_rows > 0) {
    echo "<script>
            alert('Gagal! Kegiatan dengan kode atau nama tersebut sudah ada.');
            window.history.back();
        </script>";
    exit;
}

$sql = "INSERT INTO kegiatan (id_program, kode_kegiatan, nama_kegiatan, is_active)
        VALUES ($id_program, '$kode', '$nama', $is_active)";

if ($k->query($sql)) {
    echo "<script>
            alert('Kegiatan berhasil ditambahkan.');
            window.location='manajemen_kegiatan.php';
          </script>";
} else {
    echo "<script>
            alert('Gagal simpan kegiatan: " . addslashes($k->error) . "');
            window.history.back();
          </script>";
}
