import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';

class NextButton extends ConsumerWidget {
  const NextButton(
    this.info, {
    Key? key,
    required this.hasNext,
    required this.onPressed,
  }) : super(key: key);

  final SizingInformation info;
  final bool hasNext;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return hasNext
        ? Container(
            margin: EdgeInsets.only(right: R.w(info, 7)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(pad),
                  child: KText(
                    "next",
                    size: R.f(info, 9),
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayText : XColors.darkColor,
                  ),
                ),
                KClickable(
                  height: R.h(info, 5),
                  width: R.w(info, 13),
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowRight,
                    color: isDarkMode ? XColors.grayText : XColors.darkColor,
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
