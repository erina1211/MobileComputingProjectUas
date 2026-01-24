import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  // Fungsi validasi format email
  bool isValidEmail(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final email = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Nama"),
            ),

            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // ================= VALIDASI =================
                if (name.text.isEmpty ||
                    email.text.isEmpty ||
                    pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Semua field wajib diisi"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (!isValidEmail(email.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Format email tidak valid!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                // ===========================================

                final success = await AuthService.register(
                  name.text,
                  email.text,
                  pass.text,
                );

                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Register berhasil"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Register gagal"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
