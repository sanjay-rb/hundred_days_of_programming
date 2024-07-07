import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';

class LoginController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isLogin = true.obs;
  RxBool isLoading = true.obs;

  changeIsLogin() {
    isLogin.value = !isLogin.value;
  }

  signInOrUp() async {
    bool canLogin = false;
    if (isLogin.value) {
      canLogin = await Get.find<AuthService>().signIn(
        email.text,
        password.text,
      );
    } else {
      canLogin = await Get.find<AuthService>().signUp(
        name.text,
        email.text,
        password.text,
      );
    }
    if (canLogin) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
