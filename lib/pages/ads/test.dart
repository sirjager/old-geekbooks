import 'package:geeklibrary/ads/ad_ids.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class TestAds extends StatefulWidget {
  const TestAds({Key? key}) : super(key: key);

  @override
  _TestAdsState createState() => _TestAdsState();
}

class _TestAdsState extends State<TestAds> {
  final bannerController = BannerAdController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestAds"),
      ),
      body: SafeArea(
        child: Center(
          child: BannerAd(
          
            unitId: AdId.imageBanner,
            controller: bannerController,
            loading: Center(child: CircularProgressIndicator()),
            error: Center(child: Text("Error")),
            builder: (_, sd) => Center(
              child: BannerAd(),
            ),
          ),
        ),
      ),
    );
  }
}
