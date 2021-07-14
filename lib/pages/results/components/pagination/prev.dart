import 'package:geeklibrary/backend/functions/math/colors_genrator.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';

class PreviousButton extends ConsumerWidget {
  const PreviousButton(
    this.info, {
    Key? key,
    required this.hasPrev,
    required this.onPressed,
  }) : super(key: key);

  final SizingInformation info;
  final bool hasPrev;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return hasPrev
        ? Container(
            margin: EdgeInsets.only(left: R.w(info, 7)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(pad),
                  child: KText(
                    "previous",
                    size: R.f(info, 9),
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayColor : XColors.darkColor,
                  ),
                ),
                KClickable(
                  height: R.h(info, 5),
                  width: R.w(info, 13),
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowLeft,
                    color: Colors.black,
                  ),
                  topDeco: isDarkMode
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: G.blackGradButtonDeco.gradient,
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                              colors: [randomLightColor(), randomLightColor()]),
                        ),
                  bottomDeco: isDarkMode
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                              colors: [Colors.black, randomLightColor()]),
                        )
                      : G.blackGradButtonDeco,
                ),
              ],
            ),
          )
        : Container();
  }
}
