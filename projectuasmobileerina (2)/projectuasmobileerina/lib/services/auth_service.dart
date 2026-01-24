import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api.dart';

class AuthService {
  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse("${Api.baseUrl}/auth/login.php");

    final response = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
    );

    return json.decode(response.body);
  }

  // ================= REGISTER =================
  static Future<bool> register(
      String name, String email, String password) async {
    final url = Uri.parse("${Api.baseUrl}/auth/register.php");

    final response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    final data = json.decode(response.body);
    return data['success'] == true;
  }

  // ================= LOGOUT ================= ✅ INI YANG HILANG
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
