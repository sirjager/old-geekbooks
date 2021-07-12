import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';

class PreviousButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
