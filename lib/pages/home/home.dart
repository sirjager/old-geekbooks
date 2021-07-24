import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/ads/ads_defaults.dart';
import 'package:geeklibrary/core/responsive/builder/responsive_builder.dart';
import 'package:geeklibrary/core/responsive/size/responsive_size.dart';

import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/screentitle/titlebar.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FocusNode _node = FocusNode();
  late final ad1;

  @override
  void initState() {
    ad1 = new BannerAdController();

    super.initState();
  }

  @override
  void dispose() {
    ad1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildShapes(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              ScreenTopbar(),
              ScreenTitlebar(title: "Browse Library"),
              Searchbar(_node),
              SearchOptions(),
              SizedBox(height: 100.h),
              Spacer(),
              // buildAd(100, 15, ad1)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAd(double w, double h, BannerAdController _controller) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Container(
          width: R.w(info, w),
          height: R.h(info, h),
          child: BannerAd(
            controller: _controller,
            unitId: DefaultAds.bannerAdUnitId,
            error: Container(),
            loading: Container(),
            builder: (context, child) {
              return BannerAd(
                keywords: ["Education"],
                size: BannerSize(
                  Size(R.w(info, w), R.h(info, h)),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildShapes() {
    return Consumer(
      builder: (context, watch, child) {
        var isDarkMode = watch(themeProvider).isDarkMode;
        return Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Image.asset(
                    "assets/images/shapes/login_bottom.png",
                    width: 400.w,
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.07)
                        : XColors.grayColor.withOpacity(0.2),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: isDarkMode ? 1500.h : 100.h,
                left: isDarkMode ? 950.w : 50.w,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 3),
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 2),
                  height: isDarkMode ? 250.w : 350.w,
                  width: isDarkMode ? 250.w : 350.w,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.07)
                        : Colors.green.withOpacity(0.07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
