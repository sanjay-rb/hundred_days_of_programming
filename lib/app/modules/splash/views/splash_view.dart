import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/assets_service.dart';
import 'package:hundred_days_of_programming/app/services/in_app_update_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                Assets.assetsImageIcon,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<String?>(
              future: InAppUpdateService.checkForUpdate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: Get.size.width * .5,
                    child: LinearProgressIndicator(
                      color: Get.theme.colorScheme.secondary.withOpacity(.3),
                    ),
                  );
                }
                String? goolePlayURL = snapshot.data;

                if (goolePlayURL != null) {
                  Future(() async {
                    bool result = await Get.dialog(
                      AlertDialog(
                        backgroundColor: Get.theme.colorScheme.primary,
                        icon: const Icon(Icons.warning),
                        title: const Text("Update available!"),
                        content: const Text(
                            "Please update the app for new features."),
                        actions: [
                          TextButton.icon(
                            onPressed: () {
                              Get.back<bool>(result: false);
                            },
                            icon: Icon(Icons.close,
                                color: Get.theme.colorScheme.tertiary),
                            label: Text(
                              "Skip",
                              style: TextStyle(
                                  color: Get.theme.colorScheme.tertiary),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              Get.back<bool>(result: true);
                            },
                            icon: Icon(Icons.done,
                                color: Get.theme.colorScheme.secondary),
                            label: Text(
                              "Update now",
                              style: TextStyle(
                                  color: Get.theme.colorScheme.secondary),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (result) {
                      if (await launchUrl(Uri.parse(goolePlayURL))) {
                        SystemNavigator.pop();
                      }
                    } else {
                      Get.offAllNamed(Routes.LOGIN);
                    }
                  });
                } else {
                  Future(() {
                    Get.offAllNamed(Routes.LOGIN);
                  });
                }
                return SizedBox(
                  width: Get.size.width * .5,
                  child: LinearProgressIndicator(
                    color: Get.theme.colorScheme.secondary.withOpacity(.3),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
