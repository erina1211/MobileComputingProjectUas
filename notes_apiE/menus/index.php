<?php
require_once '../config/cors.php';
// Mengaktifkan pengaturan CORS

require_once '../config/database.php';
// Menghubungkan ke database

$res = mysqli_query($conn,"SELECT * FROM menus ORDER BY id DESC");
// Mengambil semua data menu dari tabel menus
// Diurutkan dari ID terbaru

$data = [];
// Menyiapkan array kosong untuk menampung data menu

while($row = mysqli_fetch_assoc($res)){
  $data[] = $row;
  // Memasukkan setiap baris hasil query ke dalam array $data
}

echo json_encode($data);
// Mengirim data menu dalam format JSON ke Flutter
