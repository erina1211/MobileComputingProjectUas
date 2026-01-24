class MenuModel {
  // Class MenuModel digunakan sebagai model data menu (misalnya menu makanan)

  final int id;
  // id menyimpan identitas unik dari menu

  final String name;
  // name menyimpan nama menu

  final String description;
  // description menyimpan deskripsi menu

  final double price;
  // price menyimpan harga menu dengan tipe double (desimal)

  final String image;
  // image menyimpan URL atau nama file gambar menu

  MenuModel({
    required this.id,
    // id wajib diisi saat objek MenuModel dibuat

    required this.name,
    // name wajib diisi saat objek dibuat

    required this.description,
    // description wajib diisi saat objek dibuat

    required this.price,
    // price wajib diisi saat objek dibuat

    required this.image,
    // image wajib diisi saat objek dibuat
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    // factory constructor untuk membuat objek MenuModel dari data JSON (API)

    return MenuModel(
      id: int.parse(json['id'].toString()),
      // Mengambil nilai id dari JSON lalu mengubahnya ke tipe int

      name: json['name'],
      // Mengambil data name dari JSON

      description: json['description'],
      // Mengambil data description dari JSON

      price: double.parse(json['price'].toString()),
      // Mengambil data price dari JSON dan mengubahnya ke tipe double
      // 🔥 FIX: mencegah error jika price dari API berupa String atau int

      image: json['image'],
      // Mengambil data image dari JSON
    );
  }
}