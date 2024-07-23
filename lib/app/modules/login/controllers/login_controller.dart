import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

enum AuthType { signIn, signUp, resetPassword }

class LoginController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Rx<AuthType> currentAuthType = AuthType.signIn.obs;
  RxBool isLoading = true.obs;

  String? validateFormFields(String value) {
    if (value.isEmpty) {
      return "Please complete the field before submitting.";
    }
    return null;
  }

  changeAuthTypeTo(AuthType type) {
    name.text = "";
    email.text = "";
    password.text = "";
    currentAuthType.value = type;
  }

  signIn() async {
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
      String? resultStr = await Get.find<AuthService>().signIn(
        email.text,
        password.text,
      );
      Get.back(closeOverlays: true);
      if (resultStr == null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        LoggerService.error(resultStr);
      }
    }
  }

  signUp() async {
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
      String? resultStr = await Get.find<AuthService>().signUp(
        name.text,
        email.text,
        password.text,
      );
      Get.back(closeOverlays: true);
      if (resultStr == null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        LoggerService.error(resultStr);
      }
    }
  }

  resetPassword() async {
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
      String? resultStr =
          await Get.find<AuthService>().resetPassword(email.text);
      Get.back(closeOverlays: true);
      if (resultStr == null) {
        LoggerService.info(
          "A password reset link has been sent to your email. Please check your inbox and update your password accordingly.",
        );
      } else {
        LoggerService.error(resultStr);
      }
    }
  }
}
