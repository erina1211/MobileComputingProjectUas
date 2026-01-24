import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/menu_model.dart';

class MenuService {

  /// GET ALL MENUS
  static Future<List<MenuModel>> getMenus() async {
    final r = await http.get(
      Uri.parse("${Api.baseUrl}/menus/index.php"),
    );

    final List data = jsonDecode(r.body);
    return data.map((e) => MenuModel.fromJson(e)).toList();
  }

  /// ADD MENU
  static Future<bool> addMenu(Map data) async {
    final r = await http.post(
      Uri.parse("${Api.baseUrl}/menus/store.php"),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(r.body)['success'] == true;
  }

  /// 🔄 UPDATE MENU
  static Future<bool> updateMenu(Map data) async {
    final r = await http.post(
      Uri.parse("${Api.baseUrl}/menus/update.php"),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(r.body)['success'] == true;
  }

  /// ❌ DELETE MENU
  static Future<bool> deleteMenu(int id) async {
    final r = await http.post(
      Uri.parse("${Api.baseUrl}/menus/delete.php"),
      body: jsonEncode({'id': id}),
      headers: {'Content-Type': 'application/json'},
    );

    return jsonDecode(r.body)['success'] == true;
  }
}
