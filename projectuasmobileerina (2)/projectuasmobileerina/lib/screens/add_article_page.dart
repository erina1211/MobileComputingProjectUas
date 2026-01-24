import 'package:flutter/material.dart';
import '../services/article_service.dart';

class AddArticlePage extends StatelessWidget {
  const AddArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Article")),
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
              child: const Text("Save"),
              onPressed: () async {
                if (title.text.isEmpty || content.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Field tidak boleh kosong")),
                  );
                  return;
                }

                final success = await ArticleService.addArticle(
                  title.text,
                  content.text,
                );

                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Article berhasil ditambahkan"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Gagal menambahkan article"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
