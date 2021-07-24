import 'package:flutter/foundation.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class DefaultAds {
  static String get nativeAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.nativeAdTestUnitId;
    else
      return 'your-native-ad-unit-id';
  }

  static String get bannerAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.bannerAdTestUnitId;
    else
      return 'you-banner-ad-unit-id';
  }

  static String get interstitialAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.interstitialAdTestUnitId;
    else
      return 'you-interstitial-ad-unit-id';
  }

  static String get rewardedAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.rewardedAdTestUnitId;
    else
      return 'you-interstitial-ad-unit-id';
  }

  static String get appOpenAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.appOpenAdTestUnitId;
    else
      return 'you-app-open-ad-unit-id';
  }

  static String get rewardedInterstitialAdUnitId {
    /// Always test with test ads
    if (kDebugMode)
      return MobileAds.rewardedInterstitialAdTestUnitId;
    else
      return 'you-interstitial-ad-unit-id';
  }
}
