$nilai = $_POST['nilai_bulanan'];

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
