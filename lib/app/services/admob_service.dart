import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends GetxService {
  BannerAd? bannerAd;
  Rx<bool> isLoaded = false.obs;
  List<String> adUnitIds = dotenv.env['ANDROID_BANNER_AD_ID']!.split(',');

  /// Loads a banner ad.
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

  Future<void> closeAd() async {
    await bannerAd?.dispose();
  }
}
