import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

class ProfileController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController github = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  RxBool isEditing = false.obs;

  @override
  Future<void> onInit() async {
    name.text = Get.find<AuthService>().user.value.name!;
    bio.text = Get.find<AuthService>().user.value.bio!;
    github.text = Get.find<AuthService>().user.value.github!;
    linkedin.text = Get.find<AuthService>().user.value.linkedin!;
    super.onInit();
  }

  Future<void> updateUserProfile() async {
    Get.focusScope?.unfocus();
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
    try {
      UserModel currentUser = Get.find<AuthService>().user.value;

      currentUser.name = name.text;
      currentUser.bio = bio.text;
      if (github.text.endsWith('/')) {
        github.text = github.text.substring(0, github.text.length - 1);
      }
      currentUser.github = github.text;
      if (linkedin.text.endsWith('/')) {
        linkedin.text = linkedin.text.substring(0, linkedin.text.length - 1);
      }
      currentUser.linkedin = linkedin.text;

      await currentUser.updateUser();

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.back(closeOverlays: true);
      LoggerService.error(e.toString());
    }
  }

  Future<void> signOut() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
    try {
      await Get.find<AuthService>().signOut();
    } catch (e) {
      Get.back(closeOverlays: true);
      LoggerService.error(e.toString());
    }
  }

  Future<void> deleteUser() async {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
    try {
      await Get.find<AuthService>().deleteUser();
    } catch (e) {
      Get.back(closeOverlays: true);
      LoggerService.error(e.toString());
    }
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }
}
