import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.PROFILE);
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Text(
              user.name![0],
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
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
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
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
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )
            : IconButton(
                onPressed: () {
                  Get.changeThemeMode(ThemeMode.dark);
                },
                icon: Icon(
                  Icons.dark_mode_sharp,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
      ],
    );
  }
}
