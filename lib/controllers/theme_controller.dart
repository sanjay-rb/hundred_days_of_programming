import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  toggleTheme() {
    if (isDark.value) {
      Get.changeThemeMode(ThemeMode.light);
      isDark.value = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      isDark.value = true;
    }
  }
}
