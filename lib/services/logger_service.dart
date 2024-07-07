import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LoggerService {
  static info(String log) {
    Get.snackbar('INFO', log);
    FirebaseAnalytics.instance.printInfo(info: log);
    debugPrint("INFO :: $log");
  }

  static error(String log) {
    Get.snackbar('ERROR', log);
    FirebaseAnalytics.instance.printError(info: log);
    debugPrint("ERROR :: $log");
  }
}
