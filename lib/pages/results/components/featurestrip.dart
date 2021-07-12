import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/export/export.dart';

class FeatureStrip extends ConsumerWidget {
  const FeatureStrip(this.info, {Key? key}) : super(key: key);
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    var blackwhite = watch(blackNWhiteProvider);
    return Container(
      height: R.h(info, 5),
      margin: EdgeInsets.symmetric(vertical: R.h(info, 1)),
      padding: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
      alignment: Alignment.center,
      color: isDarkMode ? XColors.darkColor2 : randomLightColor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          KText(
            "black and white images",
            font: "Poppins",
            size: R.f(info, 10),
          ),
          SizedBox(width: R.w(info, 10)),
          Switch(
            onChanged: (bool value) => blackwhite.setBlackNWhite(value),
            value: blackwhite.blackNWhite,
          ),
        ],
      ),
    );
  }
}
