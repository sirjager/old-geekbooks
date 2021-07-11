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
            margin: const EdgeInsets.symmetric(horizontal: pad),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(pad),
                  child: KText(
                    "next",
                    size: 10,
                    weight: FontWeight.bold,
                  ),
                ),
                KClickable(
                  height: R.h(info, 5),
                  width: R.w(info, 16),
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowRight,
                    color: Colors.black,
                  ),
                  topDeco: G.green2GradBannerDeco,
                  bottomDeco: G.blackGradButtonDeco,
                ),
              ],
            ),
          )
        : Container();
  }
}
