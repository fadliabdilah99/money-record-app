import 'package:d_chart/d_chart.dart';
import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/controller/c_history.dart';
import 'package:money_record/presentation/controller/c_laporanHarian.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/page/auth/login_page.dart';
import 'package:money_record/presentation/page/history/HistoryPage.dart';
import 'package:money_record/presentation/page/history/addhistory.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final cUser = Get.put(Cuser());
  final cHistory = Get.put(CHistory());
  final cLaporanHarian = Get.put(CLaporanHarian());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void refresh() {
    cHistory.getList(cUser.data.idUser ?? "", '', '');
    final userId = cUser.data.idUser ?? "";
    cHistory.getTotalHistory(userId);
    cLaporanHarian.getlaporanHistory(userId);
    cHistory.getPengeluaranHistory(userId);
    cHistory.getPengeluaranHistory(userId);
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refresh();
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              bool? isYes = await DInfo.dialogConfirmation(
                context,
                'Logout?',
                'Kamu Yakin Ingin LogOut?',
              );
              if (isYes ?? false) {
                Session.clearUser();
                Get.back();
                Get.offAll(const LoginPage());
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo,',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[400],
                          ),
                        ),
                        Obx(
                          () => Text(
                            cUser.data.name.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColor.chart,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor
                              .secondary, // Ganti warna background sesuai keinginan Anda
                          borderRadius: BorderRadius.circular(
                              10), // Sesuaikan border radius dengan keinginan Anda
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Get.to(const addHistory())
                                    ?.then((_) => refresh());
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add History"),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 0, 0, 0)!),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor
                              .primary, // Ganti warna background sesuai keinginan Anda
                          borderRadius: BorderRadius.circular(
                              10), // Sesuaikan border radius dengan keinginan Anda
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Catatan Keuangan',
                              style: TextStyle(color: AppColor.secondary),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Total pengeluaran:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.light,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Obx(
                                  () {
                                    final pengeluaranAmount =
                                        cHistory.pengeluaranAmount;
                                    if (pengeluaranAmount != null &&
                                        pengeluaranAmount.isNotEmpty) {
                                      return Text(
                                        AppFormat.currency(pengeluaranAmount),
                                        style: TextStyle(
                                          color: Colors.red[400],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        'No data', // Tampilkan pesan yang sesuai jika data tidak valid
                                        style: TextStyle(
                                          color: Colors
                                              .red, // Warna teks merah untuk menunjukkan data tidak valid
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                LottieBuilder.asset(
                                  AppAsset.pengeluaran,
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor
                              .primary, // Ganti warna background sesuai keinginan Anda
                          borderRadius: BorderRadius.circular(
                              10), // Sesuaikan border radius dengan keinginan Anda
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Catatan Keuangan',
                                style: TextStyle(color: AppColor.secondary)),
                            const SizedBox(height: 5),
                            const Text(
                              'Total pemasukan:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.light,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Obx(
                                  () {
                                    final totalAmount = cHistory.totalAmount;
                                    if (totalAmount != null &&
                                        totalAmount.isNotEmpty) {
                                      return Text(
                                        AppFormat.currency(totalAmount),
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 84, 255, 93),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        'No data',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                LottieBuilder.asset(
                                  AppAsset.pemasukan,
                                  width: 50,
                                  height: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(
                              10), // Sesuaikan border radius dengan keinginan Anda
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Get.to(const HistoryPage())
                                    ?.then((_) => refresh());
                              },
                              icon: const Icon(Icons.history),
                              label: const Text("Cek History"),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 0, 0, 0)),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBarO(
                  groupList: [
                    OrdinalGroup(
                      id: '1',
                      data: [
                        OrdinalData(domain: 'Mon', measure: 29),
                        OrdinalData(domain: 'Tue', measure: 25),
                        OrdinalData(domain: 'Wed', measure: 50),
                        OrdinalData(domain: 'Thu', measure: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Data', style: TextStyle(fontSize: 20.0)),
                      const SizedBox(
                          height:
                              10), // Tambahkan jarak antara judul dan daftar
                      Obx(
                        () {
                          // Gunakan Obx untuk mendengarkan perubahan pada data
                          if (cLaporanHarian.loading) {
                            // Tampilkan indikator loading jika sedang memuat
                            return const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors
                                    .blue, // Warna latar belakang indikator loading
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white), // Warna indikator loading
                              ),
                            );
                          } else if (cLaporanHarian.list.isEmpty) {
                            // Tampilkan pesan jika daftar kosong
                            return const Center(
                              child: Text(
                                'Tidak ada data',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey), // Warna teks
                              ),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: cLaporanHarian.list.length,
                              itemBuilder: (context, index) {
                                final laporan = cLaporanHarian.list[index];
                                return Card(
                                  elevation: 4.0, // Tingkat elevasi kartu
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0)), // Bentuk kartu
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10.0), // Jarak dari tepi layar
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    title: Text(
                                      'Tanggal: ${laporan.tanggal}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0), // Gaya teks judul
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8.0),
                                        Text(
                                            'Total Pemasukan: ${laporan.total_pemasuka}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .green)), // Warna teks pemasukan
                                        const SizedBox(height: 4.0),
                                        Text(
                                            'Total Pengeluaran: ${laporan.total_pengeluaran}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .red)), // Warna teks pengeluaran
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
