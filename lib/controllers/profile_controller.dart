import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/controllers/auth_controller.dart';
import 'package:hundred_days_of_programming/models/user_model.dart';

class ProfileController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController github = TextEditingController();
  final TextEditingController linkedin = TextEditingController();
  UserModel? user;
  final AuthController authController = Get.find();
}
