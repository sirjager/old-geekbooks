import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsState {
  AdsState({required this.initAds});
  Future<InitializationStatus> initAds;

  String get bannerAdUnitID {
    if (Platform.isAndroid) {
      return "ca-app-pub-9510752255420297~7975368104";
    } else {
      return "ca-app-pub-9510752255420297~1545691124";
    }
  }

  BannerAdListener get bannerAdListener => _adListener;

  BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print("\nAd Loaded\n"),
    onAdFailedToLoad: (Ad ad, LoadAdError err) {
      ad.dispose();
      print("\nAd Failed to load : $err\n");
    },
    onAdOpened: (Ad ad) => print("\nAd Opened\n"),
    onAdClosed: (Ad ad) => print("\nAd Closed\n"),
    onAdImpression: (Ad ad) => print("\nAd Impresssion\n"),
  );
}
