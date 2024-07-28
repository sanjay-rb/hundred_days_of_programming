import 'package:get/get.dart';

class HowController extends GetxController {
  final currentStep = 0.obs;
  final totalStep = 5 - 1;

  setCurrentStep(int value) {
    currentStep.value = value;
  }
}
