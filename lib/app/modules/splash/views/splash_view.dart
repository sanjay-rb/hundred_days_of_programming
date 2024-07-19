import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/assets_service.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 90,
          height: 90,
          child: Image.asset(
            Assets.assetsImageIcon,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
