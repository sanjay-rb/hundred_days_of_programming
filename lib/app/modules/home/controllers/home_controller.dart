import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hundred_days_of_programming/app/data/models/task_model.dart';

class HomeController extends GetxController {
  Rx<List<TaskModel>> tasks = Rx<List<TaskModel>>([]);
  BannerAd? bannerAd;

  @override
  Future<void> onInit() async {
    List<TaskModel> data = await TaskModel.getTaskDetails();
    tasks.value = data;
    super.onInit();
  }

  Future<Widget> loadAD() async {
    List<String> adUnitIds = dotenv.env['ANDROID_BANNER_AD_ID']!.split(',');
    adUnitIds.shuffle();

    bannerAd = BannerAd(
      adUnitId: adUnitIds.first,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('BannerAd loaded successfully : ${ad.adUnitId}');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    );
    await bannerAd?.load();
    return SizedBox(
      key: UniqueKey(),
      width: bannerAd?.size.width.toDouble(),
      height: bannerAd?.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!, key: UniqueKey()),
    );
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    super.onClose();
  }
}
