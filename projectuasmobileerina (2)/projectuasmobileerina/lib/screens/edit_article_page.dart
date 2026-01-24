import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';

class EditArticlePage extends StatefulWidget {
  final ArticleModel article;

  const EditArticlePage({super.key, required this.article});

  @override
  State<EditArticlePage> createState() => _EditArticlePageState();
}

class _EditArticlePageState extends State<EditArticlePage> {
  late TextEditingController title;
  late TextEditingController content;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.article.title);
    content = TextEditingController(text: widget.article.content);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Edit Article")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: content,
            decoration: const InputDecoration(labelText: "Content"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              if (title.text.isEmpty || content.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tidak boleh kosong")),
                );
                return;
              }

              final success = await ArticleService.updateArticle(
                widget.article.id,
                title.text,
                content.text,
              );

              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Article diupdate")),
                );
                Navigator.pop(context, true);
              }
            },
          )
        ],
      ),
    ),
  );
}
