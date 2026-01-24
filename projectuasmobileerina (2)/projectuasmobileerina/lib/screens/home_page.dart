import 'package:flutter/material.dart';

// Services
import '../services/menu_service.dart';
import '../services/auth_service.dart';

// Models
import '../models/menu_model.dart';

// Pages
import 'add_menu_page.dart';
import 'detail_menu_page.dart';
import 'login_page.dart';
import 'article_page.dart'; // ✅ TAMBAH INI

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MenuModel>> _menus;

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  void _loadMenus() {
    _menus = MenuService.getMenus();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Jasa Titip Makanan"),
      actions: [
        /// 📰 ARTICLE BUTTON
        IconButton(
          icon: const Icon(Icons.article),
          tooltip: "Articles",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ArticlePage()),
            );
          },
        ),

        /// 🔥 LOGOUT BUTTON
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(c, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(c, true),
                    child: const Text("Logout"),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await AuthService.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                      (_) => false,
                );
              }
            }
          },
        ),
      ],
    ),

    /// 📋 MENU LIST
    body: FutureBuilder<List<MenuModel>>(
      future: _menus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No menu available"),
          );
        }

        final menus = snapshot.data!;

        return ListView.builder(
          itemCount: menus.length,
          itemBuilder: (context, index) {
            final menu = menus[index];

            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: ListTile(
                leading: Image.network(
                  menu.image,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image),
                ),
                title: Text(menu.name),
                subtitle: Text("Rp ${menu.price}"),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMenuPage(menu: menu),
                    ),
                  );

                  if (result == true) {
                    setState(() => _loadMenus());
                  }
                },
              ),
            );
          },
        );
      },
    ),

    /// ➕ ADD MENU
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddMenuPage(),
          ),
        );

        if (result == true) {
          setState(() => _loadMenus());
        }
      },
    ),
  );
}
