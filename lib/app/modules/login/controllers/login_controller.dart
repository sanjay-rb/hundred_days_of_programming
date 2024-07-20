import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

class LoginController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isLogin = true.obs;
  RxBool isLoading = true.obs;

  String? validateFormFields(String value) {
    if (value.isEmpty) {
      return "Please complete the field before submitting.";
    }
    return null;
  }

  changeIsLogin() {
    name.text = "";
    email.text = "";
    password.text = "";
    isLogin.value = !isLogin.value;
  }

  signInOrUp() async {
    Get.focusScope?.unfocus();
    if (formKey.currentState!.validate()) {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: Get.theme.colorScheme.secondary,
          ),
        ),
        barrierDismissible: false,
      );

      String? resultStr = "";
      if (isLogin.value) {
        resultStr = await Get.find<AuthService>().signIn(
          email.text,
          password.text,
        );
      } else {
        resultStr = await Get.find<AuthService>().signUp(
          name.text,
          email.text,
          password.text,
        );
      }
      if (resultStr == null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.back(closeOverlays: true);
        LoggerService.error(resultStr);
      }
    }
  }
}
