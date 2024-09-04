import 'package:get/get.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/source/source_history.dart';

class CHistory extends GetxController {
  final _loading = false.obs;
  bool get loading => _loading.value;

  final _list = <History>[].obs;
  List<History> get list => _list;

  final _totalAmount = ''.obs;
  String get totalAmount => _totalAmount.value; 

  final _pengeluaranAmount = ''.obs;
  String get pengeluaranAmount => _pengeluaranAmount.value; 

  getList(idUSer, date1, date2) async {
    _loading.value = true;
    update();

    _list.value = await SourceHistory.history(idUSer, date1, date2);
    update();

    Future.delayed(const Duration(milliseconds: 900), () {
      _loading.value = false;
      update();
    });
  }

  Future<void> getTotalHistory(String idUser) async {
    _loading.value = true;
    update();

    Map response = await SourceHistory.getTotalHistory(idUser);

    if (response['success']) {
      _totalAmount.value = response['data']['total_amount'];
    } else {
      // Handle error
    }

    _loading.value = false;
    update();
  }


  Future<void> getPengeluaranHistory(String idUser) async {
    _loading.value = true;
    update();

    Map response = await SourceHistory.getPengeluaranHistory(idUser);

    if (response['success']) {
      _pengeluaranAmount.value = response['data']['total_amount'];
    } else {
      // Handle error
    }

    _loading.value = false;
    update();
  }
}