import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InAppUpdateService extends GetxService {
  static late PackageInfo packageInfo;

  @override
  Future<void> onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }

  static Future<void> checkUpdate() async {
    await Future.delayed(const Duration(seconds: 2));
    final DocumentSnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance
            .collection("version")
            .doc(packageInfo.packageName)
            .get();
    final Map<String, dynamic>? data = response.data();
    if (data != null) {
      if (data['version'] != packageInfo.version ||
          data['build_number'] != packageInfo.buildNumber) {
        bool? result = await Get.dialog<bool>(
          AlertDialog(
            backgroundColor: Get.theme.colorScheme.primary,
            title: const Text("Update available!"),
            content: const Text("Please update the app for new features."),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Get.back<bool>(result: false);
                },
                icon: Icon(Icons.close, color: Get.theme.colorScheme.tertiary),
                label: Text(
                  "Skip",
                  style: TextStyle(color: Get.theme.colorScheme.tertiary),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  Get.back<bool>(result: true);
                },
                icon: Icon(Icons.done, color: Get.theme.colorScheme.secondary),
                label: Text(
                  "Update now",
                  style: TextStyle(color: Get.theme.colorScheme.secondary),
                ),
              ),
            ],
          ),
        );
        if (result != null) {
          if (result) {
            String googlePlayLink =
                "https://play.google.com/store/apps/details?id=${packageInfo.packageName}";
            if (await canLaunchUrlString(googlePlayLink)) {
              await launchUrlString(googlePlayLink);
              SystemNavigator.pop();
            }
          } else {
            Get.offAllNamed(Routes.LOGIN);
          }
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}
