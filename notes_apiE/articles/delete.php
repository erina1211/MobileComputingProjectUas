<?php
require_once '../config/cors.php';
// Mengaktifkan pengaturan CORS

require_once '../config/database.php';

$id = $_POST['id'] ?? null;

if (!$id) {
  echo json_encode([
    "success" => false,
    "message" => "ID tidak ditemukan"
  ]);
  exit;
}

$query = mysqli_query($conn, "
  DELETE FROM articles WHERE id='$id'
");

if ($query && mysqli_affected_rows($conn) > 0) {
  echo json_encode([
    "success" => true,
    "message" => "Article berhasil dihapus"
  ]);
} else {
  echo json_encode([
    "success" => false,
    "message" => "Article gagal dihapus atau tidak ditemukan",
    "error" => mysqli_error($conn)
  ]);
}
