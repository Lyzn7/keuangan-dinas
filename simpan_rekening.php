<?php
include 'koneksi.php';

$id_subkegiatan = isset($_POST['id_subkegiatan']) ? (int)$_POST['id_subkegiatan'] : 0;
$kode           = trim($_POST['kode'] ?? '');
$nama           = trim($_POST['nama'] ?? '');
$is_active      = isset($_POST['is_active']) ? (int)$_POST['is_active'] : 1;

if (!$id_subkegiatan || $kode === '' || $nama === '') {
    echo "<script>alert('Input tidak lengkap.'); window.history.back();</script>";
    exit;
}

$kode = $k->real_escape_string($kode);
$nama = $k->real_escape_string($nama);

$cek = $k->query("
    SELECT id_rekening FROM rekening 
    WHERE id_subkegiatan=$id_subkegiatan
      AND (kode_rekening='$kode' OR nama_rekening='$nama')
    LIMIT 1
");

if ($cek->num_rows > 0) {
    echo "<script>
            alert('Gagal! Rekening dengan kode atau nama tersebut sudah ada.');
            window.history.back();
        </script>";
    exit;
}

$sql = "INSERT INTO rekening (id_subkegiatan, kode_rekening, nama_rekening, is_active)
        VALUES ($id_subkegiatan, '$kode', '$nama', $is_active)";

if ($k->query($sql)) {
    echo "<script>
            alert('Rekening berhasil ditambahkan.');
            window.location='manajemen_rekening.php';
          </script>";
} else {
    echo "<script>
            alert('Gagal simpan rekening: " . addslashes($k->error) . "');
            window.history.back();
          </script>";
}
