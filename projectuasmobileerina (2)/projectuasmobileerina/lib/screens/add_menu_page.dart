import 'package:flutter/material.dart';
import '../services/menu_service.dart';
import '../utils/rupiah_formatter.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final n = TextEditingController();
  final d = TextEditingController();
  final p = TextEditingController();
  final i = TextEditingController();

  bool loading = false;

  Future<void> saveMenu() async {
    if (n.text.isEmpty || d.text.isEmpty || p.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field wajib diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final price = int.parse(p.text.replaceAll(RegExp(r'[^0-9]'), ''));

    setState(() => loading = true);

    final success = await MenuService.addMenu({
      "name": n.text,
      "description": d.text,
      "price": price,
      "image": i.text,
    });

    setState(() => loading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Menu berhasil ditambahkan"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal menambahkan menu"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Add Menu")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: n,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        TextField(
          controller: d,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        TextField(
          controller: p,
          keyboardType: TextInputType.number,
          inputFormatters: [RupiahInputFormatter()],
          decoration: const InputDecoration(labelText: "Price"),
        ),
        TextField(
          controller: i,
          decoration: const InputDecoration(labelText: "Image URL"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: loading ? null : saveMenu,
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Save"),
        )
      ]),
    ),
  );
}
