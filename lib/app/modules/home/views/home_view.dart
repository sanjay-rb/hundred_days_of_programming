import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/admob_ad_widget.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/search_widget.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/start_or_resume_btn_widget.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/streak_widget.dart';
import 'package:hundred_days_of_programming/app/modules/home/views/widgets/header_widget.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_bar_widget.dart';
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

              final UserModel? user = snapshot.data?.data();
              if (user == null) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }

              return ListView(
                children: [
                  HeaderWidget(user: user),
                  const SizedBox(height: 15),
                  SearchWidget(user: user),
                  const SizedBox(height: 15),
                  StreakWidget(user: user),
                  const SizedBox(height: 15),
                  StartOrResumeBtnWidget(user: user),
                  const SizedBox(height: 15),
                  Card(
                    color: Theme.of(context).colorScheme.primary,
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
                  const SizedBox(height: 15),
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
      bottomNavigationBar: const AdmobAdWidget(),
    );
  }
}
