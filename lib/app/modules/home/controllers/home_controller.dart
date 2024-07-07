import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';

class HomeController extends GetxController {
  final TextEditingController search = TextEditingController();
  Rx<List<TaskModel>> tasks = Rx<List<TaskModel>>([]);
  @override
  Future<void> onInit() async {
    List<TaskModel> data = await TaskModel.getTaskDetails();
    tasks.value = data;
    super.onInit();
  }
}
