import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/source/source_history.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/page/history/HistoryPage.dart';
import 'package:money_record/presentation/page/homepage.dart';

class UpdateHistory extends StatefulWidget {
  const UpdateHistory({Key? key}) : super(key: key);

  @override
  State<UpdateHistory> createState() => _UpdateHistoryState();
}

class _UpdateHistoryState extends State<UpdateHistory> {
  String? selectedType;

  final cUser = Get.put(Cuser());

  final controllerid = TextEditingController();
  final controlleridh = TextEditingController();
  final controllertype = TextEditingController();
  final controllerDate = TextEditingController();
  final controllertotal = TextEditingController();
  final controllerketerangan = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override

        
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments = Get.arguments;
    controlleridh.text = arguments['id'] ?? '';
    controllertype.text = arguments['type'] ?? '';
    controllerDate.text = arguments['date'] ?? '';
    controllertotal.text = arguments['total'] ?? '';
    controllerketerangan.text = arguments['details'] ?? '';
  }

  void history() async {
    try {
      bool success = await SourceHistory.updateHistory(
        cUser.data.idUser.toString(),
        controlleridh.text,
        controllertype.text,
        controllerDate.text,
        controllertotal.text,
        controllerketerangan.text,
        context,
      );
      if (success) {
        DInfo.dialogSuccess(context, 'Berhasil menambahkan data');
        DInfo.closeDialog(context, actionAfterClose: () {
         
        });
      } else {
        DInfo.dialogError(context, 'Gagal memasukkan data');
      }
    } catch (e) {
      print('Error: $e');
      DInfo.dialogError(context, 'Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.secondary,
        title: const Text(
          "Update History",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    DView.height(10),
                    Visibility(
                      visible: false,
                      child: TextFormField(
                        controller: controlleridh,
                        decoration: const InputDecoration(
                          hintText: 'IDh',
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    TextFormField(
                      controller: controllerDate,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: AppColor.secondary,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (selectedDate != null) {
                          controllerDate.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date must be selected';
                        }
                        return null;
                      },
                    ),
                    DView.height(10),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue;
                          controllertype.text = newValue ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap pilih tipe';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Pilih tipe',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(
                          Icons.list_alt,
                          color: AppColor.secondary,
                        ),
                      ),
                      items: ['pemasukan', 'pengeluaran']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controllertotal,
                      onChanged: (value) {
                        setState(() {
                          // Here you can do some processing if needed
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Total';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Total',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(
                          Icons.monetization_on,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 4,
                      controller: controllerketerangan,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Keterangan',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(
                          Icons.book,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    DView.height(30),
                    ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState?.validate() ?? false) {
                          history();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondary,
                        minimumSize: const Size(500, 50),
                      ),
                      child: const Text('Tambahkan'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
