import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_text_form_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';

import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  TaskView(this.task, {super.key});

  final TaskModel task;
  final List<CompletedTasks> completedTasks =
      Get.find<AuthService>().user.value.completedTasks!;

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
              if (completedTasks
                  .any((element) => element.taskID == task.id)) ...[
                const Divider(),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    Chip(
                      label: Text(
                        DateFormat.yMMMMd().add_jms().format(completedTasks
                            .where(
                              (element) => element.taskID == task.id,
                            )
                            .first
                            .submittedDate!
                            .toDate()),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                      avatar: Icon(
                        Icons.done,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    InkWell(
                      onTap: () {
                        controller.openGithubURL(task.id);
                      },
                      child: Chip(
                        label: Text(
                          'GitHub',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        avatar: Icon(
                          Icons.link,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.openLinkedInURL(task.id);
                      },
                      child: Chip(
                        label: Text(
                          'LinkedIn',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        avatar: Icon(
                          Icons.link,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
              ] else ...[
                const SizedBox()
              ],
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
              completedTasks.any((element) => element.taskID == task.id)
                  ? const SizedBox()
                  : UiButtonWidget(
                      text: 'Mark as Completed',
                      width: double.infinity,
                      height: 50,
                      onTap: () async {
                        if (controller.canComplete()) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Mark as Complete"),
                              content: Form(
                                key: controller.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: UiTextFormFieldWidget(
                                        controller: controller.github,
                                        validator: (String value) {
                                          return controller.validateURLFields(
                                            value,
                                            'github',
                                          );
                                        },
                                        label: "GitHub Link",
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        bgColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        icon: Icons.link,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: UiTextFormFieldWidget(
                                        controller: controller.linkedin,
                                        validator: (String value) {
                                          return controller.validateURLFields(
                                            value,
                                            'linkedin',
                                          );
                                        },
                                        label: "LinkedIn Link",
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        bgColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        icon: Icons.link,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                UiButtonWidget(
                                  text: "Completed",
                                  width: MediaQuery.of(context).size.width * .3,
                                  height: 50,
                                  onTap: () {
                                    controller.markAsComplete(task.id!);
                                  },
                                )
                              ],
                            ),
                          );
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
