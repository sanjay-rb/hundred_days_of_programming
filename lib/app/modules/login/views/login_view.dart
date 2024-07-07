import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/modules/login/controllers/login_controller.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/auth_service.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_button_widget.dart';
import 'package:hundred_days_of_programming/app/widgets/ui_text_form_field_widget.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Get.find<AuthService>().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
          bool? isLoggedIn = snapshot.data;
          if (isLoggedIn != null) {
            if (!isLoggedIn) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .15,
                                    child: Image.asset('assets/icon/icon.png'),
                                  ),
                                ),
                                Obx(
                                  () => controller.isLogin.value
                                      ? const SizedBox()
                                      : const SizedBox(height: 25),
                                ),
                                Obx(
                                  () => controller.isLogin.value
                                      ? const SizedBox()
                                      : UiTextFormFieldWidget(
                                          controller: controller.name,
                                          label: "Name",
                                          bgColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          icon: Icons.account_circle,
                                        ),
                                ),
                                const SizedBox(height: 25),
                                UiTextFormFieldWidget(
                                  controller: controller.email,
                                  label: "Email",
                                  bgColor:
                                      Theme.of(context).colorScheme.secondary,
                                  textColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  icon: Icons.email,
                                ),
                                const SizedBox(height: 25),
                                UiTextFormFieldWidget(
                                  controller: controller.password,
                                  label: "Password",
                                  bgColor:
                                      Theme.of(context).colorScheme.secondary,
                                  textColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  icon: Icons.password,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 25),
                                UiButtonWidget(
                                  text: controller.isLogin.value
                                      ? 'Sign In'
                                      : 'Sign Up',
                                  width:
                                      MediaQuery.of(context).size.width * .40,
                                  height: 40,
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      await controller.signInOrUp();
                                    }
                                  },
                                ),
                                const SizedBox(height: 25),
                                InkWell(
                                  onTap: () {
                                    controller.changeIsLogin();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '${controller.isLogin.value ? 'New to' : 'Already on'} "100 Days of Programming"? '),
                                        TextSpan(
                                          text: controller.isLogin.value
                                              ? ' Sign Up'
                                              : ' Sign In',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                letterSpacing: 3,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              );
            }
          }
          Future.delayed(Duration.zero, () {
            Get.offAllNamed(Routes.HOME);
          });
          return const SizedBox();
        },
      ),
    );
  }
}
