<?php
require_once '../config/cors.php';
// Mengaktifkan pengaturan CORS
require_once '../config/database.php';

$id = $_POST['id'] ?? null;
$title = $_POST['title'] ?? '';
$content = $_POST['content'] ?? '';

if (!$id || empty($title) || empty($content)) {
  echo json_encode([
    "success" => false,
    "message" => "Data tidak lengkap"
  ]);
  exit;
}

$query = mysqli_query($conn, "
  UPDATE articles 
  SET title='$title', content='$content'
  WHERE id='$id'
");

if ($query && mysqli_affected_rows($conn) > 0) {
  echo json_encode([
    "success" => true,
    "message" => "Article berhasil diupdate"
  ]);
} else {
  echo json_encode([
    "success" => false,
    "message" => "Tidak ada data yang berubah",
    "error" => mysqli_error($conn)
  ]);
}
