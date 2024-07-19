import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/task_search_delegate.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/admob_service.dart';
import 'package:hundred_days_of_programming/app/services/assets_service.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_bar_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_list_tile_widget.dart';

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

              UserModel? user = snapshot.data?.data();
              if (user == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }

              return ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *
                        (Get.size.width >= 600 ? .5 : .35),
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
                              Get.isDarkMode
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
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: TaskSearchDelegate(
                                  controller.tasks.value,
                                  user,
                                ),
                              );
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Material(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.5),
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.search),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "eg: 3 / Multipication and Division",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                              child: Get.isDarkMode
                                                  ? Image.asset(Assets
                                                      .assetsImageColdStreak)
                                                  : Image.asset(Assets
                                                      .assetsImageHotStreak),
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
                              task: controller.tasks.value[index],
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
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SafeArea(
          child: (Get.find<AdmobService>().isLoaded.value &&
                  Get.find<AdmobService>().bannerAd != null)
              ? SizedBox(
                  width:
                      Get.find<AdmobService>().bannerAd?.size.width.toDouble(),
                  height:
                      Get.find<AdmobService>().bannerAd?.size.height.toDouble(),
                  child: AdWidget(ad: Get.find<AdmobService>().bannerAd!),
                )
              : const SizedBox(
                  width: 320,
                  height: 50,
                  child: Center(child: Text("Advertisements")),
                ),
        ),
      ),
    );
  }
}
