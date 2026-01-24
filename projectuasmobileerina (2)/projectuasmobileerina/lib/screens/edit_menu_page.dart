import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import '../services/menu_service.dart';

class EditMenuPage extends StatefulWidget {
  final MenuModel menu;

  const EditMenuPage({super.key, required this.menu});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  late TextEditingController name;
  late TextEditingController price;
  late TextEditingController desc;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.menu.name);
    price = TextEditingController(text: widget.menu.price.toString());
    desc = TextEditingController(text: widget.menu.description);
  }

  Future<void> submit() async {
    if (name.text.isEmpty || price.text.isEmpty || desc.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field wajib diisi"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final success = await MenuService.updateMenu({
      'id': widget.menu.id,
      'name': name.text,
      'price': price.text,
      'description': desc.text,
    });

    setState(() => loading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Menu berhasil diupdate"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal update menu"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Edit Menu")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
              controller: name,
              decoration: const InputDecoration(labelText: "Name")),
          TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price")),
          TextField(
              controller: desc,
              decoration:
              const InputDecoration(labelText: "Description")),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: loading ? null : submit,
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Update"),
          ),
        ],
      ),
    ),
  );
}
