import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

class InAppUpdateService extends GetxService {
  static late PackageInfo packageInfo;

  @override
  Future<void> onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    super.onInit();
  }

  static Future<String?> checkForUpdate() async {
    String googlePlayLink =
        "https://play.google.com/store/apps/details?id=${packageInfo.packageName}";

    final http.Response data = await http.get(Uri.parse(googlePlayLink));
    final String versionPlusBuildNumber = data.body
        .split('>Version:')
        .last
        .split('<br>')
        .first
        .removeAllWhitespace;
    final String lastestVersion = versionPlusBuildNumber.split("+").first;
    final String lastestBuildNumber = versionPlusBuildNumber.split("+").last;
    debugPrint(
        "${packageInfo.version} != $lastestVersion || ${packageInfo.buildNumber} != $lastestBuildNumber");
    debugPrint((packageInfo.version != lastestVersion ||
            packageInfo.buildNumber != lastestBuildNumber)
        .toString());
    if (packageInfo.version != lastestVersion ||
        packageInfo.buildNumber != lastestBuildNumber) {
      return googlePlayLink;
    }
    return null;
  }
}
