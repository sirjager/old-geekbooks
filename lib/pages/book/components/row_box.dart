import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';

class RowBox extends ConsumerWidget {
  final String field;
  final String value;

  RowBox({required this.value, required this.field});

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
            size: 50.sp,
            googleFont: GoogleFonts.poppins(),
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(width: 30.w),
          KText(
            value,
            googleFont: GoogleFonts.poppins(),
            color: _theme.isDarkMode ? XColors.grayText1 : XColors.darkColor,
            size: 40.sp,
            maxLines: 3,
            textAlign: TextAlign.right,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
