import 'package:flutter/material.dart';
// Mengimpor widget Material Flutter

import 'package:shared_preferences/shared_preferences.dart';
// Mengimpor SharedPreferences untuk menyimpan & menghapus session login

import 'login_page.dart';
// Mengimpor halaman login

class ProfilePage extends StatelessWidget {
  // ProfilePage bersifat Stateless karena hanya menampilkan data user

  const ProfilePage({super.key});

  Future<void> logout(BuildContext context) async {
    // Fungsi logout untuk menghapus session dan kembali ke login

    final prefs = await SharedPreferences.getInstance();
    // Mengambil instance SharedPreferences

    await prefs.clear();
    // Menghapus semua data session user (token, email, dll)

    if (!context.mounted) return;
    // Mengecek apakah context masih aktif

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      // Pindah ke halaman login
          (route) => false,
      // Menghapus seluruh halaman sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold sebagai kerangka halaman

      appBar: AppBar(
        title: const Text('Profile'),
        // Judul AppBar

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            // Icon logout di AppBar

            onPressed: () => logout(context),
            // Memanggil fungsi logout saat ditekan
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        // Memberi jarak di semua sisi body

        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              // Ukuran avatar

              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ),
              // Menampilkan foto profil dari internet
            ),

            SizedBox(height: 20),
            // Jarak vertikal

            Text(
              'User Login',
              // Nama user (sementara masih statis)
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 6),
            // Jarak kecil

            Text('user@email.com'),
            // Email user (sementara masih statis)
          ],
        ),
      ),
    );
  }
}
