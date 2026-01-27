<?php
require_once '../config/cors.php';
// Mengizinkan akses API dari domain lain (CORS)

require_once '../config/database.php';

$email = $_POST['email'];
$password = $_POST['password'];

$query = mysqli_query(
  $conn,
  "SELECT * FROM users WHERE email='$email' LIMIT 1"
);

if (mysqli_num_rows($query) == 0) {
  echo json_encode([
    "success" => false,
    "message" => "Email tidak terdaftar"
  ]);
  exit;
}

$user = mysqli_fetch_assoc($query);

// ================== PASSWORD CHECK ==================
if (!password_verify($password, $user['password'])) {
  echo json_encode([
    "success" => false,
    "message" => "Password salah"
  ]);
  exit;
}

// ================== SUCCESS ==================
echo json_encode([
  "success" => true,
  "message" => "Login berhasil",
  "user" => [
    "id" => $user['id'],
    "name" => $user['name'],
    "email" => $user['email']
  ]
]);
