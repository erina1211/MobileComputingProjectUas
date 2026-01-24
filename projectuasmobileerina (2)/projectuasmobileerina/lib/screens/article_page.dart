import 'package:flutter/material.dart';
import '../services/article_service.dart';
import '../models/article_model.dart';
import 'add_article_page.dart';
import 'detail_article_page.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<List<ArticleModel>> _articles;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _articles = ArticleService.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),

      body: FutureBuilder<List<ArticleModel>>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada article"));
          }

          final articles = snapshot.data!;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, i) {
              final a = articles[i];

              return ListTile(
                title: Text(a.title),
                subtitle: Text(a.content),
                onTap: () async {
                  final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailArticlePage(article: a),
                    ),
                  );

                  if (res == true) {
                    setState(() => _load());
                  }
                },
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final res = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddArticlePage()),
          );

          if (res == true) {
            setState(() => _load());
          }
        },
      ),
    );
  }
}
