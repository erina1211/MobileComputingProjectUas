<?php
$conn = mysqli_connect("localhost","tify9948_erina","erina121104","tify9948_restaurant");
// Membuat koneksi ke database MySQL


if(!$conn){
    die("Connection Failed: ". mysqli_connect_error());
    // Jika koneksi gagal, tampilkan pesan error dan hentikan program
}
