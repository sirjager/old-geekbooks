import 'package:geeklibrary/export/export.dart';

class ColumnBox extends ConsumerWidget {
  const ColumnBox({Key? key, required this.field, required this.value})
      : super(key: key);

  final String field;
  final String value;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin: EdgeInsets.only(
        top: 60.h,
        left: 50.w,
        right: 50.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KText(
            field,
            size: 50.sp,
            googleFont: GoogleFonts.poppins(),
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 30.h),
          KText(
            value,
            googleFont: GoogleFonts.poppins(),
            color: _theme.isDarkMode ? XColors.grayText1 : XColors.darkColor,
            size: 40.sp,
            maxLines: 3,
            textAlign: TextAlign.left,
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
