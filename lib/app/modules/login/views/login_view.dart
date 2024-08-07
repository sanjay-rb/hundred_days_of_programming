import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/modules/login/controllers/login_controller.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/assets_service.dart';
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
                color: Get.theme.colorScheme.secondary,
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: Get.theme.colorScheme.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .15,
                                          child: Image.asset(
                                            Assets.assetsImageIcon,
                                          ),
                                        ),
                                      ),
                                      Obx(() => controller
                                                  .currentAuthType.value ==
                                              AuthType.signUp
                                          ? Column(
                                              children: [
                                                const SizedBox(height: 25),
                                                UiTextFormFieldWidget(
                                                  controller: controller.name,
                                                  validator: (value) {
                                                    return controller
                                                        .validateFormFields(
                                                            value);
                                                  },
                                                  label: "Name",
                                                  bgColor: Get.theme.colorScheme
                                                      .secondary,
                                                  textColor: Get.theme
                                                      .colorScheme.tertiary,
                                                  icon: Icons.account_circle,
                                                ),
                                              ],
                                            )
                                          : const SizedBox()),
                                      const SizedBox(height: 25),
                                      UiTextFormFieldWidget(
                                        controller: controller.email,
                                        validator: (value) {
                                          return controller
                                              .validateFormFields(value);
                                        },
                                        label: "Email",
                                        bgColor:
                                            Get.theme.colorScheme.secondary,
                                        textColor:
                                            Get.theme.colorScheme.tertiary,
                                        icon: Icons.email,
                                      ),
                                      Obx(
                                        () => controller
                                                    .currentAuthType.value ==
                                                AuthType.resetPassword
                                            ? const SizedBox()
                                            : Column(
                                                children: [
                                                  const SizedBox(height: 25),
                                                  UiTextFormFieldWidget(
                                                    controller:
                                                        controller.password,
                                                    validator: (value) {
                                                      return controller
                                                          .validateFormFields(
                                                              value);
                                                    },
                                                    label: "Password",
                                                    bgColor: Get.theme
                                                        .colorScheme.secondary,
                                                    textColor: Get.theme
                                                        .colorScheme.tertiary,
                                                    icon: Icons.password,
                                                    isPassword: true,
                                                  ),
                                                ],
                                              ),
                                      ),
                                      const SizedBox(height: 25),
                                      Obx(
                                        () => Column(
                                          children: [
                                            ...controller.currentAuthType
                                                        .value ==
                                                    AuthType.signIn
                                                ? [
                                                    UiButtonWidget(
                                                      text: 'Sign In',
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                      height: 40,
                                                      onTap: () {
                                                        controller.signIn();
                                                      },
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType.signUp,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'New to "100 Days of Programming"? '),
                                                            TextSpan(
                                                              text: ' Sign Up',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType
                                                              .resetPassword,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'Forgot Password ? '),
                                                            TextSpan(
                                                              text: ' Reset',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                : [],
                                            ...AuthType.signUp ==
                                                    controller
                                                        .currentAuthType.value
                                                ? [
                                                    UiButtonWidget(
                                                      text: 'Sign Up',
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                      height: 40,
                                                      onTap: () {
                                                        controller.signUp();
                                                      },
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType.signIn,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'Already on "100 Days of Programming"? '),
                                                            TextSpan(
                                                              text: ' Sign In',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType
                                                              .resetPassword,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'Forgot Password ? '),
                                                            TextSpan(
                                                              text: ' Reset',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                : [],
                                            ...controller.currentAuthType
                                                        .value ==
                                                    AuthType.resetPassword
                                                ? [
                                                    UiButtonWidget(
                                                      text: 'Reset',
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                      height: 40,
                                                      onTap: () {
                                                        controller
                                                            .resetPassword();
                                                      },
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType.signIn,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'Already on "100 Days of Programming"? '),
                                                            TextSpan(
                                                              text: ' Sign In',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 25),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeAuthTypeTo(
                                                          AuthType.signUp,
                                                        );
                                                      },
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            const TextSpan(
                                                                text:
                                                                    'New to "100 Days of Programming"? '),
                                                            TextSpan(
                                                              text: ' Sign Up',
                                                              style: Get
                                                                  .theme
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                color: Get
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                                letterSpacing:
                                                                    3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                          style: Get
                                                              .theme
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(
                                                                  color: Get
                                                                      .theme
                                                                      .colorScheme
                                                                      .tertiary),
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                : [],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
