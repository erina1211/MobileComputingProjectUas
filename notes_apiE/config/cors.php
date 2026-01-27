<?php
header("Access-Control-Allow-Origin: *");
// Mengizinkan API diakses dari domain mana pun (Flutter, web, dll)

header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
// Mengizinkan metode HTTP yang boleh digunakan

header("Access-Control-Allow-Headers: Content-Type, Authorization");
// Mengizinkan header Content-Type dan Authorization

header("Content-Type: application/json");
// Menentukan bahwa response API bertipe JSON

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    // Jika request bertipe OPTIONS (preflight request dari browser)
    http_response_code(200);
    // Kirim status OK
    exit;
    // Hentikan proses agar tidak lanjut ke script lain
}
