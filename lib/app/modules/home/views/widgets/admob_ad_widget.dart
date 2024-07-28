import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/admob_service.dart';

class AdmobAdWidget extends StatelessWidget {
  const AdmobAdWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: Get.find<AdmobService>().loadAD(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 320,
            height: 50,
            child: Center(child: Text("Advertisements")),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
