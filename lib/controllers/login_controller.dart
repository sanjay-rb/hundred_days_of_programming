import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/controllers/auth_controller.dart';
import 'package:hundred_days_of_programming/services/logger_service.dart';

class LoginController extends GetxController {
  final TextEditingController name = TextEditingController(text: "New User");
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();

  RxBool isLogin = true.obs;

  changeIsLogin() {
    isLogin.value = !isLogin.value;
  }

  signInOrUp() async {
    bool canLogin = false;
    if (isLogin.value) {
      canLogin = await authController.signIn(
        email.text,
        password.text,
      );
    } else {
      canLogin = await authController.signUp(
        name.text,
        email.text,
        password.text,
      );
    }
    if (canLogin) {
      Get.offAllNamed('/home');
    } else {
      LoggerService.error("Unable to login, please check you internet!");
    }
  }
}
