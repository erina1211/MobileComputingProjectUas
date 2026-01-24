import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/article_service.dart';
import 'edit_article_page.dart';

class DetailArticlePage extends StatelessWidget {
  final ArticleModel article;

  const DetailArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.createdAt),
            const SizedBox(height: 10),
            Text(article.content),
            const SizedBox(height: 20),

            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                  onPressed: () async {
                    final res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditArticlePage(article: article),
                      ),
                    );

                    if (res == true && context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                ),

                const SizedBox(width: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text("Delete"),
                        content:
                        const Text("Yakin ingin menghapus article ini?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(c, false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true),
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final success =
                      await ArticleService.deleteArticle(article.id);

                      if (!context.mounted) return;

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Article berhasil dihapus"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Gagal menghapus article"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
