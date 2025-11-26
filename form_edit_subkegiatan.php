<?php
session_start();
include 'koneksi.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if (!$id) {
    $_SESSION['flash_msg'] = "ID subkegiatan tidak ditemukan.";
    header("Location: manajemen_subkegiatan.php");
    exit;
}

$res = $k->query("SELECT * FROM subkegiatan WHERE id_subkegiatan = $id LIMIT 1");
$data = $res ? $res->fetch_assoc() : null;

if (!$data) {
    $_SESSION['flash_msg'] = "Subkegiatan tidak ditemukan.";
    header("Location: manajemen_subkegiatan.php");
    exit;
}

$keg = $k->query("SELECT id_kegiatan, nama_kegiatan FROM kegiatan WHERE is_active=1 ORDER BY nama_kegiatan");
?>
<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8">
<title>Edit Subkegiatan</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

<div class="card shadow">
    <div class="card-header bg-primary text-white">
        Edit Subkegiatan
    </div>

    <div class="card-body">
        <form action="update_subkegiatan.php" method="post">

            <input type="hidden" name="id_subkegiatan" value="<?= $data['id_subkegiatan'] ?>">

            <!-- Kode Subkegiatan -->
            <div class="mb-3">
                <label class="form-label">Kode Subkegiatan</label>
                <input type="text" name="kode_subkegiatan" class="form-control"
                       value="<?= htmlspecialchars($data['kode_subkegiatan']) ?>" required>
            </div>

            <!-- Pilih Kegiatan -->
            <div class="mb-3">
                <label class="form-label">Pilih Kegiatan</label>
                <select name="id_kegiatan" class="form-select" required>
                    <?php while($kegiatan = $keg->fetch_assoc()): ?>
                        <option value="<?= $kegiatan['id_kegiatan'] ?>"
                            <?= $kegiatan['id_kegiatan'] == $data['id_kegiatan'] ? 'selected' : '' ?>>
                            <?= htmlspecialchars($kegiatan['nama_kegiatan']) ?>
                        </option>
                    <?php endwhile; ?>
                </select>
            </div>

            <!-- Nama Subkegiatan -->
            <div class="mb-3">
                <label class="form-label">Nama Subkegiatan</label>
                <input type="text" name="nama_subkegiatan" class="form-control"
                       value="<?= htmlspecialchars($data['nama_subkegiatan']) ?>" required>
            </div>

            <!-- Status -->
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="is_active" class="form-select">
                    <option value="1" <?= $data['is_active'] ? 'selected' : '' ?>>Aktif</option>
                    <option value="0" <?= !$data['is_active'] ? 'selected' : '' ?>>Nonaktif</option>
                </select>
            </div>
            <div class="col-12 d-flex justify-content-between">
                <a href="manajemen_subkegiatan.php" class="btn btn-secondary">Batal</a>
                <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
            </div>
        </form>
    </div>
</div>

</div>
</body>
</html>
