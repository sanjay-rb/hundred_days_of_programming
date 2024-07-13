import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
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
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 50,
                  child: Text(
                    Get.find<AuthService>().user.value.name![0],
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
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
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
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
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    Get.find<AuthService>().user.value.email!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                const SizedBox(height: 30),
                UiTextFormFieldWidget(
                  controller: controller.name,
                  label: "Name",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
                  icon: Icons.account_circle,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.bio,
                  label: "Brief Bio",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
                  icon: Icons.star,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.github,
                  label: "GitHub",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
                  icon: Icons.link,
                  isEditable: controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                UiTextFormFieldWidget(
                  controller: controller.linkedin,
                  label: "LinkedIn",
                  textColor: Theme.of(context).colorScheme.tertiary,
                  bgColor: controller.isEditing.value
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.tertiary,
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
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              UserModel currentUser =
                                  Get.find<AuthService>().user.value;

                              currentUser.name = controller.name.text;
                              currentUser.bio = controller.bio.text;
                              currentUser.github = controller.github.text;
                              currentUser.linkedin = controller.linkedin.text;

                              await Get.find<AuthService>().updateUser();
                              Get.offAllNamed(Routes.HOME);
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
                    Get.find<AuthService>().signOut();
                  },
                ),
                const SizedBox(height: 70),
                Text(
                  "Delete this account ?",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.red,
                      ),
                ),
                Text(
                  "Once you delete an account, there's no going back. All your task records will be deleted as well!",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Get.find<AuthService>().deleteUser();
                  },
                  child: SizedBox(
                    height: 50,
                    child: Material(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
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
