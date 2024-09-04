import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/source/source_history.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/page/homepage.dart';

// ignore: camel_case_types
class addHistory extends StatefulWidget {
  const addHistory({super.key});

  @override
  State<addHistory> createState() => _addHistoryState();
}

// ignore: camel_case_types
class _addHistoryState extends State<addHistory> {
  String? selectedType;

  final cUser = Get.put(Cuser());

  final controllerid = TextEditingController();
  final controllertype = TextEditingController();
  final controllerDate = TextEditingController();
  final controllertotal = TextEditingController();
  final controllerketerangan = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (cUser.data.idUser is! int) {
      print(
          "idUser is not an integer, resetting to default value or handling it accordingly.");
    }
  }

  void history() async {
    try {
      bool success = await SourceHistory.addhistory(
        cUser.data.idUser.toString(), // Mengonversi idUser ke dalam string
        controllertype.text,
        controllerDate.text,
        controllertotal.text,
        controllerketerangan.text,
        context,
      );
      if (success) {
        DInfo.dialogSuccess(context, 'Berhasil menambakan data');
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        DInfo.dialogError(context, 'Gagal memasukkan data');
      }
    } catch (e) {
      print('Error: $e');
      // ignore: use_build_context_synchronously
      DInfo.dialogError(context, 'Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.secondary,
        // elevation: 4, // Set the elevation to add a shadow
        title: const Text(
          "Tambahkan Catatan",
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
          padding: const EdgeInsets.only(left: 30, right: 30),
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
                        controller: controllerid,
                        decoration: const InputDecoration(
                          hintText: 'id',
                        ),
                        onChanged: (value) {
                          setState(() {
                            cUser.data.idUser = value;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      controller: controllerDate,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        hintStyle: const TextStyle(color: Colors.grey),
                        // labelText: 'Date',
                        prefixIcon: const Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.secondary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
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
                          // Format the selected date and set it to the controller
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
                        // Handle dropdown value changes
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
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        hintText: 'Pilih tipe',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Total';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        hintText: 'total',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
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
                      // obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        hintText: 'keterangan',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
