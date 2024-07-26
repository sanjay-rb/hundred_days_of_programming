import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/services/assets_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_bar_widget.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              "${user.completedTasks!.length}/100",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${user.streak} ",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Get.isDarkMode
                      ? Image.asset(Assets.assetsImageColdStreak)
                      : Image.asset(Assets.assetsImageHotStreak),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
