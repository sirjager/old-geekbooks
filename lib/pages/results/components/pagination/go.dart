import 'package:geekbooks/export/export.dart';

class GoButton extends StatelessWidget {
  const GoButton(
    this.info, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final SizingInformation info;

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return KClickable(
      height: R.h(info, 4),
      width: R.w(info, 10),
      onPressed: () => onPressed(),
      child: KText(
        "go",
        size: 11,
        weight: FontWeight.bold,
      ),
      topDeco: G.redGradBannerDeco,
      bottomDeco: G.blackGradButtonDeco,
    );
  }
}
