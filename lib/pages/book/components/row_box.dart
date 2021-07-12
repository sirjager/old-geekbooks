import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';

class RowBox extends ConsumerWidget {
  final String field;
  final String value;
  final SizingInformation info;

  RowBox(this.info, {required this.value, required this.field});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin:
          const EdgeInsets.only(top: pad * 2, left: pad * 2, right: pad * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(
            field,
            size: R.f(info, 17),
            font: "Poppins",
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(width: pad),
          KText(
            value,
            font: "Poppins",
            color: XColors.grayText,
            size: R.f(info, 12),
            maxLines: 3,
            textAlign: TextAlign.right,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
