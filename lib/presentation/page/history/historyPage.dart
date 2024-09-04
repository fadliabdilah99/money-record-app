import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/data/model/history.dart';
import 'package:money_record/data/source/source_history.dart';
import 'package:money_record/presentation/controller/c_history.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/page/history/update.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final controllerDate1 = TextEditingController();
  final controllerDate2 = TextEditingController();
  final controllerIdHistory = TextEditingController();

  final cHistory = Get.put(CHistory());
  final cUser = Get.put(Cuser());
  final formKey = GlobalKey<FormState>();

  bool showDetails = false;
  int selectedHistoryIndex = -1;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    cHistory.getList(
      cUser.data.idUser,
      controllerDate1.text,
      controllerDate2.text,
    );
  }

  void deleteHistory(String idHistory) async {
    try {
      bool success = await SourceHistory.deletehistory(idHistory, context);
      if (success) {
        setState(() {
          cHistory.list
              .removeWhere((element) => element.idHistory == idHistory);
        });
      } else {
        // Handle failure case
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
        elevation: 5,
        backgroundColor: AppColor.chart,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAsset.logo,
              width: 50,
            ),
            const Text(
              'Money Saving',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controllerDate1,
                        decoration: InputDecoration(
                          hintText: 'Date',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
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
                            controllerDate1.text =
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
                    ),
                    const SizedBox(width: 10),
                    // Date 2 field
                    Expanded(
                      child: TextFormField(
                        controller: controllerDate2,
                        decoration: InputDecoration(
                          hintText: 'Date',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
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
                            controllerDate2.text =
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
                    ),
                    const SizedBox(width: 10),
                    // Filter button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          refresh();
                        }
                      },
                      child: const Text('Filter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CHistory>(
              builder: (_) {
                if (_.loading) return DView.loadingCircle();
                if (_.list.isEmpty) return DView.empty('KOSONGG');

                return RefreshIndicator(
                  onRefresh: () async => refresh(),
                  child: ListView.builder(
                    itemCount: _.list.length,
                    itemBuilder: (context, index) {
                      History history = _.list[index];
                      return Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(10.0),
                            elevation: 5.0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showDetails = !showDetails;
                                  selectedHistoryIndex = index;
                                  controllerIdHistory.text = history.idHistory!;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        (history.type == 'pemasukan')
                                            ? const Icon(Icons.arrow_drop_down,
                                                color: Colors.green)
                                            : const Icon(Icons.arrow_drop_up,
                                                color: Colors.red),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.details!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              history.date!,
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        (history.type == 'pemasukan')
                                            ? Text(
                                                '+ ${AppFormat.currency(history.total!)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              )
                                            : Text(
                                                '- ${AppFormat.currency(history.total!)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                        Text(history.type!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Detail transaksi
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            height: showDetails && selectedHistoryIndex == index
                                ? 100
                                : 0,
                            child: showDetails && selectedHistoryIndex == index
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 500,
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Detail Transaksi:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  'Jumlah: ${history.total}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  'Tipe: ${history.details}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Form(
                                              key: formKey,
                                              child: Row(
                                                children: [
                                                  Visibility(
                                                    visible: false,
                                                    child: TextFormField(
                                                      controller:
                                                          controllerIdHistory,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: 'id',
                                                      ),
                                                      onChanged: (value) {
                                                        history.idHistory =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      if (formKey.currentState
                                                              ?.validate() ??
                                                          false) {
                                                        deleteHistory(
                                                            history.idHistory!);
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      minimumSize:
                                                          const Size(50, 50),
                                                    ),
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  InkWell(
                                                    onTap: () => Get.to(
                                                      const UpdateHistory(),
                                                      arguments: {
                                                        'id': history.idHistory,
                                                        'type': history.type,
                                                        'date': history.date,
                                                        'total': history.total,
                                                        'details':
                                                            history.details,
                                                      },
                                                    ),
                                                    child:
                                                        const Icon(Icons.edit),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
