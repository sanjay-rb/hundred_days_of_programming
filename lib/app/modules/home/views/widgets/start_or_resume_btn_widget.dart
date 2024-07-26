import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/modules/home/controllers/home_controller.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';

class StartOrResumeBtnWidget extends GetWidget<HomeController> {
  const StartOrResumeBtnWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UiButtonWidget(
        width: MediaQuery.of(context).size.width * .40,
        height: 40,
        text: user.completedTasks!.isEmpty ? 'Start' : 'Resume',
        onTap: () {
          Get.toNamed(
            Routes.TASK,
            arguments: controller.tasks.value[user.completedTasks!.length],
          );
        },
      ),
    );
  }
}
