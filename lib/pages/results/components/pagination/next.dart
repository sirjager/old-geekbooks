import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';

class NextButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                  ),
                ),
                KClickable(
                  height: R.h(info, 5),
                  width: R.w(info, 13),
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowRight,
                    color: Colors.black,
                  ),
                  topDeco: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                          colors: [randomLightColor(), randomLightColor()])),
                  bottomDeco: G.blackGradButtonDeco,
                ),
              ],
            ),
          )
        : Container();
  }
}
