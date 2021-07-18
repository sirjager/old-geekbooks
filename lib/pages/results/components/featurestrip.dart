import 'package:geeklibrary/export/export.dart';

class FeatureStrip extends ConsumerWidget {
  const FeatureStrip(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    var blackwhite = watch(blackNWhiteProvider);
    return Container(
      height: R.h(info, 3),
      margin: EdgeInsets.only(top: R.h(info, 0.2), bottom: R.h(info, 0.5)),
      padding: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
      alignment: Alignment.center,
      color: theme.isDarkMode ? XColors.darkColor2 : XColors.darkGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KText(
            "Make cover images darker",
            font: "Poppins",
            size: R.f(info, 10),
            weight: FontWeight.bold,
            color: theme.isDarkMode ? XColors.grayColor : Colors.black,
          ),
          SizedBox(width: R.w(info, 10)),
          Switch.adaptive(
            onChanged: (bool value) => blackwhite.setBlackNWhite(value),
            value: blackwhite.blackNWhite,
          ),
        ],
      ),
    );
  }
}
