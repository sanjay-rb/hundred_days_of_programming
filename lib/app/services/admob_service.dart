import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {
  BannerAd? bannerAd;
  Rx<bool> isLoaded = false.obs;
  List<String> adUnitIds = dotenv.env['ANDROID_BANNER_AD_ID']!.split(',');

  /// Loads a banner ad.
  void loadAd() {
    adUnitIds.shuffle();
    bannerAd = BannerAd(
      adUnitId: adUnitIds.first,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('BannerAd loaded successfully : ${ad.adUnitId}');
          isLoaded.value = true;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        onAdClosed: (ad) {
          isLoaded.value = false;
        },
        onAdOpened: (ad) {
          isLoaded.value = true;
        },
      ),
    )..load();
  }

  Future<void> closeAd() async {
    await bannerAd?.dispose();
  }
}
