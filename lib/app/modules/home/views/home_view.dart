import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_bar_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_list_tile_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_text_form_field_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<DocumentSnapshot<UserModel>>(
              stream: UserModel.getUserStreamByID(
                  Get.find<AuthService>().user.value.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }
                UserModel user = snapshot.data!.data()!;
                return ListView(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .35,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.PROFILE);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Text(
                                      user.name![0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "Hi, ${user.name}!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Theme.of(context).brightness == Brightness.dark
                                    ? IconButton(
                                        onPressed: () {
                                          Get.changeThemeMode(ThemeMode.light);
                                        },
                                        icon: Icon(
                                          Icons.light_mode_sharp,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          Get.changeThemeMode(ThemeMode.dark);
                                        },
                                        icon: Icon(
                                          Icons.dark_mode_sharp,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            UiTextFormFieldWidget(
                              controller: controller.search,
                              label: "eg: 6 / Day 6 / Leap Year Check",
                              textColor: Theme.of(context).colorScheme.tertiary,
                              bgColor: Theme.of(context).colorScheme.secondary,
                              icon: Icons.search,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "${user.completedTasks!.length}/100",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const UiBarWidget(
                                        length: 70,
                                        isHorizontal: false,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${user.streak} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                    ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Image.asset(
                                                        'assets/image/cold_streak.png',
                                                      )
                                                    : Image.asset(
                                                        'assets/image/hot_streak.png',
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  UiButtonWidget(
                                    width:
                                        MediaQuery.of(context).size.width * .40,
                                    height: 40,
                                    text: user.completedTasks!.isEmpty
                                        ? 'Start'
                                        : 'Resume',
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.TASK,
                                        arguments: controller.tasks
                                            .value[user.completedTasks!.length],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => Column(
                            children: List.generate(
                              controller.tasks.value.length,
                              (index) => UiListTileWidget(
                                index: index,
                                user: user,
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    user.completedTasks!.length == 100
                        ? Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "THE END",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                const UiBarWidget(length: 70),
                                const SizedBox(height: 10),
                                Text(
                                  "Try again with different programming langurage",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                const UiBarWidget(length: 70),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
