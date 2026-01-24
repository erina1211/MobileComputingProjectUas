import 'package:flutter/material.dart';
// Mengimpor widget Material Flutter

import 'screens/login_page.dart';
// Mengimpor halaman login sebagai halaman awal

void main() {
  runApp(const MyApp());
  // Menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  // Widget utama aplikasi

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jastip App',
      // Judul aplikasi

      home: LoginPage(),
      // Halaman pertama yang ditampilkan adalah LoginPage
    );
  }
}
