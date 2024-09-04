import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:money_record/config/api.dart';
import 'package:money_record/config/app_request.dart';
import 'package:money_record/data/model/history.dart';

class SourceHistory {
  static Future<List<History>> history(
    String idUser,
    String date1,
    String date2,
  ) async {
    // String url = '${Api.history}/history.php';
    String url = '${Api.history}/detail.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
      'date1': date1,
      'date2': date2,
    });

    if (responseBody == null) return [];

    if (responseBody['success']) {
      dynamic data = responseBody['data'];

      if (data is List) {
        return data.map((e) => History.fromjson(e)).toList();
      } else if (data is Map<String, dynamic>) {
        // Handle single item
        return [History.fromjson(data)];
      }
    }

    return [];
  }

  static Future<bool> addhistory(
    String id,
    String type,
    String date,
    String total,
    String keterangan,
    BuildContext context,
  ) async {
    String url = '${Api.history}/add.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id,
      'type': type,
      'date': date,
      'total': total,
      'details': keterangan,
    });

    if (responseBody == null) return false;

    // if (responseBody['success']) {
    //   DInfo.dialogSuccess(context, 'Berhasil menambahkan data');
    //   DInfo.closeDialog(context);
    //   Get.off(HomePage());
    //   // Navigator.pop(context);
    // } else {
    //   DInfo.dialogError(context, 'gagal menambah data');
    // }

    return responseBody['success'];
  }

  static Future<bool> updateHistory(
    String id,
    String idHistory,
    String type,
    String date,
    String total,
    String keterangan,
    BuildContext context,
  ) async {
    String url = '${Api.history}/update.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id,
      'id_history': idHistory,
      'type': type,
      'date': date,
      'total': total,
      'details': keterangan,
    });

    if (responseBody == null) return false;
    return responseBody['success'];
  }

  static Future<bool> whredate(
    String id,
    String date1,
    String date2,
    BuildContext context,
  ) async {
    String url = '${Api.history}/detail.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': id,
      'date1': date1,
      'date2': date2,
    });

    if (responseBody == null) return false;
    return responseBody['success'];
  }

  static Future<bool> deletehistory(
    String id,
    BuildContext context,
  ) async {
    String url = '${Api.history}/delete.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_history': id,
    });

    if (responseBody == null) return false;

    if (responseBody['success']) {
      DInfo.dialogSuccess(context, "Berhasil menghapus data");
      DInfo.closeDialog(context);
    } else {
      DInfo.dialogError(context, 'gagal menambah data');
    }

    return responseBody['success'];
  }

  static Future<Map> getTotalHistory(String idUser) async {
    String url = '${Api.history}/catatanAll.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return {'success': false};
    return responseBody;
  }


  static Future<Map> getPengeluaranHistory(String idUser) async {
    String url = '${Api.history}/pengeluaranAll.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return {'success': false};

    return responseBody;
  }


  
  static Future<Map> getlaporanHistory(String idUser) async {
    String url = '${Api.history}/laporanharian.php';
    Map? responseBody = await AppRequest.post(url, {
      'id_user': idUser,
    });

    if (responseBody == null) return {'success': false};

    return responseBody;
  }
}
