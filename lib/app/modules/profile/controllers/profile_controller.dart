import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';

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

  toggleEdit() {
    isEditing.value = !isEditing.value;
  }
}
