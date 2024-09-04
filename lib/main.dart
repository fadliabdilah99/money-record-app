import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/presentation/page/ad_page.dart';
// import 'package:money_record/presentation/page/history/addhistory.dart';
import 'package:money_record/presentation/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // initializeDateFormatting('id_ID').then((value) {
  //   runApp(const MyApp());
  // });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashPage(),
      // home: FutureBuilder(
      //   future: Session.getUser(),
      //   builder: (context, AsyncSnapshot<User> snapshot) {
      //     if (snapshot.data != null && snapshot.data!.idUser != null) {
      //       return const HomePage();
      //     }
      //     return const LoginPage();
      //   },
      // ),
    );
  }
}
