import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/in_app_update_service.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    InAppUpdateService.checkUpdate();
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
