<?php
require_once '../config/cors.php';
// Mengaktifkan pengaturan CORS
require_once '../config/database.php';

$title = $_POST['title'];
$content = $_POST['content'];

$query = mysqli_query($conn,
  "INSERT INTO articles (title, content)
   VALUES ('$title', '$content')"
);

if ($query) {
  echo json_encode([
    "success" => true,
    "message" => "Article berhasil ditambahkan"
  ]);
} else {
  echo json_encode([
    "success" => false,
    "error" => mysqli_error($conn)
  ]);
}
