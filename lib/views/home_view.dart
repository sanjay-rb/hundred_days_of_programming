import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/controllers/home_controller.dart';
import 'package:hundred_days_of_programming/controllers/theme_controller.dart';
import 'package:hundred_days_of_programming/models/user_model.dart';

import 'package:hundred_days_of_programming/controllers/auth_controller.dart';
import 'package:hundred_days_of_programming/models/task_model.dart';
import 'package:hundred_days_of_programming/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/widgets/ui_list_tile_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<DocumentSnapshot<UserModel>>(
              stream: UserModel.getUserStreamByID(authController.userID.value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
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
                                    Get.toNamed('/profile');
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(.5),
                                    child: Text(
                                      user.name[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
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
                                const Spacer(),
                                themeController.isDark.value
                                    ? IconButton(
                                        onPressed: () {
                                          themeController.toggleTheme();
                                        },
                                        icon: Icon(
                                          Icons.light_mode_sharp,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          themeController.toggleTheme();
                                        },
                                        icon: Icon(
                                          Icons.dark_mode_sharp,
                                          size: 30,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: homeController.search,
                              decoration: InputDecoration(
                                hintText: "eg: 6 / Day 6 / Leap Year Check",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
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
                                            "${user.completedTasks.length}/100",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 70,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
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
                                                          .onPrimary,
                                                    ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child:
                                                    themeController.isDark.value
                                                        ? Image.asset(
                                                            'assets/image/hot_streak.png',
                                                          )
                                                        : Image.asset(
                                                            'assets/image/cold_streak.png',
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    text: Text(
                                      user.completedTasks.isEmpty
                                          ? 'Start'
                                          : 'Resume',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<QuerySnapshot<TaskModel>>(
                          future: TaskModel.getTaskDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            QuerySnapshot<TaskModel>? data = snapshot.data;
                            return Column(
                              children: List.generate(
                                data!.docs.length,
                                (index) => UiListTileWidget(
                                  index: index,
                                  task: data.docs[index].data(),
                                  user: user,
                                  event: () {
                                    Get.toNamed(
                                      '/task',
                                      arguments: data.docs[index].data(),
                                    );
                                  },
                                ),
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
