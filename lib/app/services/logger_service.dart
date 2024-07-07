import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoggerService {
  static info(String log) {
    int duration = log.split(' ').length ~/ 3;
    Get.snackbar(
      'INFO',
      log,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.info),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(
        seconds: duration < 3 ? 3 : duration,
      ),
    );
    FirebaseAnalytics.instance.printInfo(info: log);
    FirebaseAnalytics.instance.logEvent(
      name: "INFO",
      parameters: {"INFO": log},
    );
    Get.log(log, isError: false);
  }

  static error(String log) {
    int duration = log.split(' ').length ~/ 3;
    Get.snackbar(
      'ERROR',
      log,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.error),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(
        seconds: duration < 3 ? 3 : duration,
      ),
    );
    FirebaseAnalytics.instance.printError(info: log);
    FirebaseAnalytics.instance.logEvent(
      name: "ERROR",
      parameters: {"ERROR": log},
    );
    Get.log(log, isError: true);
  }
}
