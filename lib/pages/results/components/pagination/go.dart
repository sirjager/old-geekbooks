import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
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
        size: R.f(info, 12),
        weight: FontWeight.bold,
      ),
      topDeco: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient:
              LinearGradient(colors: [randomLightColor(), randomLightColor()])),
      bottomDeco: G.blackGradButtonDeco,
    );
  }
}
