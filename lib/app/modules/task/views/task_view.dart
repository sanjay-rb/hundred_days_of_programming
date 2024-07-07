import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';

import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView(this.task, {super.key});

  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Text(
                "Day ${task.day} - ${task.title}",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Description: ",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  task.description!.length,
                  (index) => Text(
                    "- ${task.description![index]}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  task.testCases!.length,
                  (index) => MarkdownBlock(
                    data: task.testCases![index],
                    config: MarkdownConfig(
                      configs: [
                        PreConfig(
                          language: 'txt',
                          styleNotMatched: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                        H3Config(
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // TODO: Need to show completed if it is already completed.
              UiButtonWidget(
                text: 'Mark as Completed',
                width: double.infinity,
                height: 50,
                onTap: () async {
                  // TODO: Need to get github and linkedin link for store in db.
                  bool result =
                      await controller.markAsComplete(task.id!, '', '');
                  if (result) {
                    Get.offAllNamed(Routes.HOME);
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
