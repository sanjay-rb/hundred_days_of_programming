import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/controllers/auth_controller.dart';
import 'package:hundred_days_of_programming/controllers/login_controller.dart';
import 'package:hundred_days_of_programming/widgets/ui_button_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: FutureBuilder<bool>(
        future: authController.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
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
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(.8),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: loginController.formKey,
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
                                  () => loginController.isLogin.value
                                      ? const SizedBox()
                                      : const SizedBox(height: 25),
                                ),
                                Obx(
                                  () => loginController.isLogin.value
                                      ? const SizedBox()
                                      : TextFormField(
                                          controller: loginController.name,
                                          decoration: InputDecoration(
                                            hintText: "Name",
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
                                                .secondary,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  controller: loginController.email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.secondary,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  controller: loginController.password,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                    filled: true,
                                    fillColor:
                                        Theme.of(context).colorScheme.secondary,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                UiButtonWidget(
                                  text: Obx(
                                    () => Text(
                                      loginController.isLogin.value
                                          ? 'Sign In'
                                          : 'Sign Up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                    ),
                                  ),
                                  color: Theme.of(context).colorScheme.primary,
                                  width:
                                      MediaQuery.of(context).size.width * .40,
                                  height: 40,
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    if (loginController.formKey.currentState!
                                        .validate()) {
                                      await loginController.signInOrUp();
                                    }
                                  },
                                ),
                                const SizedBox(height: 25),
                                InkWell(
                                  onTap: () {
                                    loginController.changeIsLogin();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '${loginController.isLogin.value ? 'New to' : 'Already on'} "100 Days of Programming"? '),
                                        TextSpan(
                                          text: loginController.isLogin.value
                                              ? ' Sign Up'
                                              : ' Sign In',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                letterSpacing: 3,
                                              ),
                                        ),
                                      ],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
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
            Get.offAllNamed('/home');
          });
          return Container();
        },
      ),
    );
  }
}
