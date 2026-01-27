<?php
require_once '../config/cors.php';
// Mengaktifkan pengaturan CORS
require_once '../config/database.php';

$data = [];
$query = mysqli_query($conn, "SELECT * FROM articles ORDER BY id DESC");

while ($row = mysqli_fetch_assoc($query)) {
  $data[] = $row;
}

echo json_encode($data);
