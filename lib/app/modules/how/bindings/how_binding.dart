import 'package:get/get.dart';

import '../controllers/how_controller.dart';

class HowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HowController>(
      () => HowController(),
    );
  }
}
