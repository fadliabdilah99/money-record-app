import 'package:get/get.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/model/laporanHarian.dart';
import 'package:money_record/data/source/source_history.dart';

class CLaporanHarian extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <LaporanHarian>[].obs;
  List<LaporanHarian> get list => _list;

  final catatanHarian = ''.obs;
  String get catatanharian => catatanHarian.value;

Future<void> getlaporanHistory(String idUser) async {
  _loading.value = true;
  update();

  Map response = await SourceHistory.getlaporanHistory(idUser);

  if (response['success']) {
    List<dynamic> data = response['data']; // Mengakses array data dari respons
    _list.clear(); // Membersihkan list sebelum menambahkan data baru
    data.forEach((item) {
      // Untuk setiap elemen dalam array data, buat objek LaporanHarian dan tambahkan ke list
      _list.add(LaporanHarian(
        tanggal: item['tanggal'],
        total_pemasuka: item['total_pemasukan'], // Perhatikan nama properti yang benar
        total_pengeluaran: item['total_pengeluaran'], // Perhatikan nama properti yang benar
      ));
    });
  } else {
    // Handle error
  }

  _loading.value = false;
  update();
}

}
