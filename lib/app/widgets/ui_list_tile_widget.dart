import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/modules/home/controllers/home_controller.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

class UiListTileWidget extends GetWidget<HomeController> {
  const UiListTileWidget({
    super.key,
    required this.user,
    required this.index,
  });

  final UserModel user;
  final int index;

  @override
  Widget build(BuildContext context) {
    TaskModel task;
    if (controller.tasks.value.isNotEmpty) {
      task = controller.tasks.value[index];
    } else {
      task = TaskModel(
        id: "id",
        day: 0,
        title: "title",
        description: [],
        testCases: [],
      );
    }
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            index <= user.completedTasks!.length ? Icons.lock_open : Icons.lock,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
      isThreeLine: true,
      title: Text(
        'Day ${task.day}',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        task.title!,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.completedTasks!
                        .where(
                          (element) => element.taskID == task.id,
                        )
                        .length ==
                    1
                ? '🟢'
                : '🔴',
          )
        ],
      ),
      onTap: () {
        if (index <= user.completedTasks!.length) {
          Get.toNamed(Routes.TASK, arguments: task);
        } else {
          LoggerService.info(
            "Please complete task $index to unlock this task",
          );
        }
      },
    );
  }
}
