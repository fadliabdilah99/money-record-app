import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/source/source_user.dart';
import 'package:money_record/presentation/page/auth/sign_in.dart';
import 'package:money_record/presentation/page/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void login() async {
    if (formkey.currentState!.validate()) {
      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );

      if (success) {
        DInfo.dialogSuccess(context, 'Berhasil Login');
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        DInfo.dialogError(context, 'Gagal Login');
        DInfo.closeDialog(context);
      }
    } else {
      // Show a snackbar if the form is not valid
      Get.snackbar(
        'Error',
        'Harap Lengkapi Data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image above the form
                    Image.asset(
                      AppAsset.logo,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary, // Change color as needed
                      ),
                      textAlign: TextAlign.center,
                    ),
                    DView.height(20),
                    // Input email with icon
                    TextFormField(
                      controller: controllerEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), // Add email icon
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    // Input password with icon
                    TextFormField(
                      controller: controllerPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock), // Add password icon
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                      ),
                    ),
                    DView.height(20),
                    // Button
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 50,
                      ),
                      child: ElevatedButton(
                        onPressed: () => login(),
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ),
                    DView.height(10),
                    InkWell(
                      onTap: () {
                        Get.to(SignIn());
                      },
                      child: Text(
                        'Belum Punya akun? Register',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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