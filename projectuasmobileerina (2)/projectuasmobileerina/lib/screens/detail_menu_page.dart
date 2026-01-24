import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../services/menu_service.dart';
import 'edit_menu_page.dart';

class DetailMenuPage extends StatelessWidget {
  final MenuModel menu;

  const DetailMenuPage({super.key, required this.menu});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(menu.name)),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Card(
            margin: const EdgeInsets.all(16),
            child: Image.network(
              menu.image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(
                height: 220,
                child: Center(
                  child: Icon(Icons.broken_image, size: 100),
                ),
              ),
              loadingBuilder: (c, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),

          /// NAME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              menu.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// PRICE
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Rp ${menu.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(menu.description),
          ),

          const SizedBox(height: 30),

          /// EDIT & DELETE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// EDIT
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditMenuPage(menu: menu),
                    ),
                  );

                  if (result == true && context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
              ),

              /// DELETE
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
                      title: const Text("Delete Menu"),
                      content: const Text(
                          "Are you sure you want to delete this menu?"),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(c, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(c, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final success =
                    await MenuService.deleteMenu(menu.id);

                    if (!context.mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Menu berhasil dihapus"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gagal menghapus menu"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
