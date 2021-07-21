import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/titlebar/titlebar.dart';

class Homepage extends StatelessWidget {
  Homepage(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildShapes(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: R.w(info, 1),
            vertical: R.statusbarHeight(info),
          ),
          child: Column(
            children: [
              Titlebar(info),
              AppTitle(info),
              Searchbar(info, _node),
              SearchOptions(info),
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
                    width: R.w(info, 45),
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.07)
                        : XColors.grayColor.withOpacity(0.1),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: isDarkMode ? R.h(info, 70) : R.h(info, 5),
                left: isDarkMode ? R.w(info, 75) : R.w(info, 1),
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 3),
                child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 2),
                  height: isDarkMode ? R.w(info, 40) : R.w(info, 30),
                  width: isDarkMode ? R.w(info, 40) : R.w(info, 30),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.green.withOpacity(0.05),
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
