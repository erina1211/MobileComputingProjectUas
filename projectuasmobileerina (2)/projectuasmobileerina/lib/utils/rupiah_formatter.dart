import 'package:flutter/services.dart';
// Digunakan untuk membuat custom input formatter

import 'package:intl/intl.dart';
// Digunakan untuk format angka dan mata uang

class RupiahInputFormatter extends TextInputFormatter {
  // Formatter khusus untuk mengubah input angka menjadi format Rupiah

  final NumberFormat formatter =
  NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  // Format mata uang Indonesia (Rp tanpa desimal)

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Method yang dipanggil setiap input teks berubah

    if (newValue.text.isEmpty) {
      // Jika input kosong, kembalikan nilai baru apa adanya
      return newValue;
    }

    final cleanText =
    newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    // Menghapus semua karakter selain angka

    final number = int.parse(cleanText);
    // Mengubah teks angka menjadi integer

    final newText = formatter.format(number);
    // Mengubah angka menjadi format Rupiah (contoh: Rp 10.000)

    return TextEditingValue(
      text: newText,
      // Menampilkan teks yang sudah diformat
      selection: TextSelection.collapsed(offset: newText.length),
      // Cursor otomatis berada di akhir teks
    );
  }
}
