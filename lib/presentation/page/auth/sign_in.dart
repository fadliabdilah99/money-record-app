import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/source/source_user.dart';
import 'package:money_record/presentation/page/auth/login_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controllerNama = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void register() async {
    if (formkey.currentState!.validate()) {
      if (controllerPassword.text != controllerConfirmPassword.text) {
        Get.snackbar(
          'Error',
          'Password and confirmation password do not match',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        bool success = await SourceUser.register(
          controllerNama.text,
          controllerEmail.text,
          controllerPassword.text,
          context,
        );
        if (success) {
          DInfo.dialogSuccess(context, 'Berhasil Membuat Akun');
        } else {
          DInfo.dialogError(context, 'Gagal Membuat Akun');
        }
      }
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
                  children: [
                    Image.asset(
                      AppAsset.logo,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DView.height(10),
                    TextFormField(
                      controller: controllerNama,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Nama';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: controllerEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 10),
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
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    DView.height(10),
                    TextFormField(
                      controller: controllerConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi Konfirmasi Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    DView.height(10),
                    ElevatedButton(
                      onPressed: () => register(),
                      child: const Text('Register'),
                    ),
                    DView.height(10),
                    InkWell(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: Text(
                        'Sudah Punya akun? Login',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
