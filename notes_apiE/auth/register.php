<?php
require_once '../config/cors.php';
// Mengatur CORS agar API bisa diakses Flutter

require_once '../config/database.php';
// Koneksi ke database

$data = json_decode(file_get_contents("php://input"), true);
// Mengambil data JSON dari request body

$name = $data['name'];
// Menyimpan nama user dari input

$email = $data['email'];
// Menyimpan email user dari input

$password = password_hash($data['password'], PASSWORD_DEFAULT);
// Mengenkripsi password menggunakan hashing bawaan PHP
// (lebih aman daripada menyimpan password asli)

mysqli_query($conn,
"INSERT INTO users(name,email,password)
 VALUES('$name','$email','$password')");
// Menyimpan data user baru ke tabel users

echo json_encode(["success"=>true]);
// Mengirim response bahwa register berhasil
