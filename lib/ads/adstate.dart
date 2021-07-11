import 'dart:io';

import 'package:geekbooks/ads/ads_man.dart';
import 'package:geekbooks/core/log/log.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState({required this.initialization});

  String get bannerAdUnitID =>
      Platform.isAndroid ? AdMan.bannerAndroid : bannerAdUnitID;

  BannerAd createBannerAd() {
    return new BannerAd(
      request: AdRequest(
        keywords: <String>['foo', 'bar'],
        contentUrl: 'http://foo.com/bar.html',
      ),
      adUnitId: bannerAdUnitID,
      size: AdSize.mediumRectangle,
      listener: bannerAdListener,
    );
  }

  BannerAdListener get bannerAdListener => _adListener;

  BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad _ad) => log.i("\nAD LOADED\n"),
    onAdClosed: (Ad _ad) => log.i("\nAD CLOSED\n"),
    onAdImpression: (Ad _ad) => log.i("\nAD IMPRESSION\n"),
    onAdOpened: (Ad _ad) => log.i("\nAD OPENED\n"),
    onAdFailedToLoad: (_ad, e) {
      log.e("\nAD LOADED ERROR\n$e");
      _ad.dispose();
    },
  );
}
