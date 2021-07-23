import 'package:geeklibrary/export/export.dart';
import 'package:readmore/readmore.dart';

class DescriptionBox extends ConsumerWidget {
  const DescriptionBox({Key? key, required this.desc}) : super(key: key);
  final String desc;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            "Description",
            size: 50.sp,
            font: "Poppins",
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(height: 30.h),
          ReadMoreText(
            desc,
            trimLength: 200,
            trimMode: TrimMode.Length,
            colorClickableText: _theme.isDarkMode
                ? Colors.lightGreenAccent[100]
                : Colors.blueAccent[100],
            style: TextStyle(
              fontFamily: "Poppins",
              color: _theme.isDarkMode ? XColors.grayText1 : XColors.darkColor,
              fontWeight: FontWeight.w400,
              fontSize: 40.sp,
            ),
          ),
        ],
      ),
    );
  }
}
