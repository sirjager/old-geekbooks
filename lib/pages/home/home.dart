import 'package:flutter/cupertino.dart';

import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/screentitle/titlebar.dart';
import 'package:lottie/lottie.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _animate = false;
  final FocusNode _node = FocusNode();

  _play() async {
    if (_animate) {
      await Future.delayed(Duration(seconds: 3))
          .then((value) => setState(() => _animate = false));
    } else {
      setState(() => _animate = true);
      await Future.delayed(Duration(seconds: 3))
          .then((value) => _animate = false);
    }
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
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => _play,
                child: Container(
                  margin: EdgeInsets.only(top: 100.h, left: 550.w),
                  child: Lottie.asset(
                    MyAssets.girlFlower,
                    repeat: _animate,
                    height: 500.w,
                  ),
                ),
              ),
              Column(
                children: [
                  ScreenTopbar(),
                  ScreenTitlebar(title: "Browse Library"),
                  Searchbar(_node),
                  SearchOptions(),
                  SizedBox(height: 100.h),
                ],
              ),
            ],
          ),
        ),
      ],
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
