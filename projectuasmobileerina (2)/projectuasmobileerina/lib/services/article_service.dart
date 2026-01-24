import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/article_model.dart';

class ArticleService {

  // ================= GET =================
  static Future<List<ArticleModel>> getArticles() async {
    final res = await http.get(
      Uri.parse("${Api.baseUrl}/articles/get.php"),
    );

    final List data = jsonDecode(res.body);
    return data.map((e) => ArticleModel.fromJson(e)).toList();
  }

  // ================= ADD =================
  static Future<bool> addArticle(
      String title,
      String content,
      ) async {

    final res = await http.post(
      Uri.parse("${Api.baseUrl}/articles/add.php"),
      body: {
        "title": title,
        "content": content,
      },
    );

    final data = jsonDecode(res.body);
    return data['success'] == true;
  }

  // ================= UPDATE =================
  static Future<bool> updateArticle(
      int id,
      String title,
      String content,
      ) async {

    final res = await http.post(
      Uri.parse("${Api.baseUrl}/articles/update.php"),
      body: {
        "id": id.toString(),
        "title": title,
        "content": content,
      },
    );

    final data = jsonDecode(res.body);
    return data['success'] == true;
  }


  // ================= DELETE =================
  static Future<bool> deleteArticle(int id) async {
    final res = await http.post(
      Uri.parse("${Api.baseUrl}/articles/delete.php"),
      body: {
        "id": id.toString(),
      },
    );

    final data = jsonDecode(res.body);
    return data['success'] == true;
  }
}
