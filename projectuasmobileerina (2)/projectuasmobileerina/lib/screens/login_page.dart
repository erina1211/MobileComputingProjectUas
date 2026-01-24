import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

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
              child: const Text("Login"),
              onPressed: () async {

                if (email.text.isEmpty || pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email dan Password wajib diisi"),
                    ),
                  );
                  return;
                }

                final res =
                await AuthService.login(email.text, pass.text);

                if (res['success'] == true) {
                  final prefs =
                  await SharedPreferences.getInstance();

                  await prefs.setInt(
                    "user_id",
                    int.parse(res['user']['id'].toString()),
                  );

                  await prefs.setBool("isLogin", true);

                  if (!context.mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        res['message'] ?? "Login gagal",
                      ),
                    ),
                  );
                }
              },
            ),

            TextButton(
              child: const Text("Register"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
