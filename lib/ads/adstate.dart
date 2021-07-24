import 'package:geeklibrary/ads/ad_ids.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState({required this.initialization});

  String get bannerAdUnitID => AdId.bannerAndroid;

  String get imageAd => AdId.imageBanner;
  String get videoAd => AdId.videoBanner;
  String get cardNativeAd => AdId.cardNativeBanner;
  String get loadingAd => AdId.loadInter;
  String get navbarAd => AdId.navNativeBanner;

  BannerAd createBannerAd({AdSize? size}) {
    return new BannerAd(
      request: AdRequest(nonPersonalizedAds: true),
      adUnitId: bannerAdUnitID,
      size: size ?? AdSize.banner,
      listener: bannerAdListener,
    );
  }

  BannerAdListener get bannerAdListener => _adListener;

  BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad _ad) => log.i("\nAD LOADED\n"),
    onAdClosed: (Ad _ad) => log.i("\nAD CLOSED\n"),
    onAdImpression: (Ad _ad) => log.i("\nAD APPEARED\n"),
    onAdOpened: (Ad _ad) => log.i("\nAD OPENED\n"),
    onAdFailedToLoad: (_ad, e) {
      log.e("\nAD LOADED ERROR\n$e");
      _ad.dispose();
    },
  );
}
