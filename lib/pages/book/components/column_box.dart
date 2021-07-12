import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';

class ColumnBox extends ConsumerWidget {
  const ColumnBox(this.info,
      {Key? key, required this.field, required this.value})
      : super(key: key);

  final String field;
  final String value;
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin:
          const EdgeInsets.only(top: pad * 2, left: pad * 2, right: pad * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KText(
            field,
           size: R.f(info, 17),
            font: "Poppins",
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(height: R.h(info, 1)),
          KText(
            value,
            font: "Poppins",
            color: XColors.grayText,
            size: R.f(info, 12),
            maxLines: 3,
            textAlign: TextAlign.left,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
