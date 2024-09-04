import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/data/model/user.dart';
import 'package:money_record/presentation/page/auth/login_page.dart';
import 'package:money_record/presentation/page/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      await _checkUserAndNavigate();
    });
  }

  Future<void> _checkUserAndNavigate() async {
    User? user = await Session.getUser();
    if (user != null && user.idUser != null) {
      Get.offAll(const HomePage());
    } else {
      Get.offAll(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.chart,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Money Saving',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                LottieBuilder.asset(
                  AppAsset.openign,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
