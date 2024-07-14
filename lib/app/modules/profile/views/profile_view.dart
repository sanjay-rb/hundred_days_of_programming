import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_text_form_field_widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => ListView(
              children: [
                Center(
                  child: Text(
                    "Profile",
                    style: Get.theme.textTheme.headlineLarge!
                        .copyWith(color: Get.theme.colorScheme.secondary),
                  ),
                ),
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Get.theme.colorScheme.secondary,
                  radius: 50,
                  child: Text(
                    Get.find<AuthService>().user.value.name![0],
                    style: Get.theme.textTheme.displayLarge!.copyWith(
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Get.find<AuthService>().user.value.name!,
                        style: Get.theme.textTheme.headlineLarge!.copyWith(
                          color: Get.theme.colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      controller.isEditing.value
                          ? IconButton.filled(
                              onPressed: () {
                                controller.toggleEdit();
                              },
                              icon: const Icon(Icons.cancel),
                              color: Colors.red,
                            )
                          : IconButton.filled(
                              onPressed: () {
                                controller.toggleEdit();
                              },
                              icon: const Icon(Icons.edit),
                              color: Get.theme.colorScheme.secondary,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    Get.find<AuthService>().user.value.email!,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                UiTextFormFieldWidget(
                  controller: controller.name,
                  label: "Name",
                  textColor: Get.theme.colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.tertiary,
                  icon: Icons.account_circle,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.bio,
                  label: "Brief Bio",
                  textColor: Get.theme.colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.tertiary,
                  icon: Icons.star,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.github,
                  label: "GitHub",
                  textColor: Get.theme.colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.tertiary,
                  icon: Icons.link,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.linkedin,
                  label: "LinkedIn",
                  textColor: Get.theme.colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Get.theme.colorScheme.secondary
                      : Get.theme.colorScheme.tertiary,
                  icon: Icons.link,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 30),
                controller.isEditing.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UiButtonWidget(
                            text: "Cancel",
                            width: MediaQuery.of(context).size.width * .3,
                            height: 50,
                            onTap: () {
                              controller.toggleEdit();
                            },
                          ),
                          UiButtonWidget(
                            text: "Save",
                            width: MediaQuery.of(context).size.width * .3,
                            height: 50,
                            onTap: () {
                              controller.updateUserProfile();
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                UiButtonWidget(
                  text: "Sign Out",
                  width: 1,
                  height: 50,
                  onTap: () {
                    controller.signOut();
                  },
                ),
                const SizedBox(height: 70),
                Text(
                  "Delete this account ?",
                  style: Get.theme.textTheme.headlineSmall!.copyWith(
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Once you delete an account, there's no going back. All your task records will be deleted as well!",
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: Get.theme.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    controller.deleteUser();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: Get.theme.textTheme.headlineSmall!.copyWith(
                            color: Get.theme.colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
