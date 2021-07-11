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
            margin: const EdgeInsets.symmetric(horizontal: pad),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(pad),
                  child: KText(
                    "previous",
                    size: 10,
                    weight: FontWeight.bold,
                  ),
                ),
                KClickable(
                  height: R.h(info, 5),
                  width: R.w(info, 16),
                  onPressed: () => onPressed(),
                  child: Icon(
                    EvaIcons.arrowLeft,
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
