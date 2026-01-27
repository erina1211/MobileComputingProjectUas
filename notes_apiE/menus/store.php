<?php
require_once '../config/cors.php';
// Mengaktifkan CORS

require_once '../config/database.php';
// Koneksi ke database

$data = json_decode(file_get_contents("php://input"), true);
// Mengambil data JSON dari body request Flutter
// lalu mengubahnya menjadi array PHP

mysqli_query($conn,
"INSERT INTO menus(name,description,price,image)
VALUES(
'{$data['name']}',
'{$data['description']}',
'{$data['price']}',
'{$data['image']}'
)"
);
// Menyimpan data menu baru ke tabel menus

echo json_encode(["success"=>true]);
// Mengirim response bahwa data berhasil disimpan
