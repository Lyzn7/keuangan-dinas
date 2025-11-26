
// Update status
$k->query("UPDATE program SET is_active = $new WHERE id_program = $id");

// Flash message
$_SESSION['flash_msg'] = $new ? "Program diaktifkan" : "Program dinonaktifkan";

// Kembali ke manajemen program
header("Location: manajemen_program.php");
exit;
