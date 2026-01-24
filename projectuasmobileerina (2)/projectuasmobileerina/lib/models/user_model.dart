class UserModel {
  // Class UserModel digunakan sebagai model data user

  final int id;
  // id menyimpan identitas unik user

  final String name;
  // name menyimpan nama user

  UserModel({
    required this.id,
    // id wajib diisi saat objek UserModel dibuat

    required this.name,
    // name wajib diisi saat objek dibuat
  });
}