import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/utils/striphtml.dart';
import 'package:readmore/readmore.dart';

class DescriptionBox extends ConsumerWidget {
  const DescriptionBox(this.info, {Key? key, required this.desc})
      : super(key: key);
  final String desc;
  final SizingInformation info;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _theme = watch(themeProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            "Description",
            size: R.f(info, 15),
            font: "Poppins",
            color: _theme.isDarkMode ? Colors.white70 : XColors.darkGray,
            weight: FontWeight.w500,
          ),
          SizedBox(height: R.h(info, 1)),
          ReadMoreText(
            XUtils.stripHtml(desc),
            trimLength: 200,
            trimMode: TrimMode.Length,
            colorClickableText: _theme.isDarkMode
                ? Colors.lightGreenAccent[100]
                : Colors.blueAccent[100],
            style: TextStyle(
              fontFamily: "Poppins",
              color: _theme.isDarkMode ? XColors.grayText1 : XColors.darkColor,
              fontWeight: FontWeight.w400,
              fontSize: R.f(info, 11),
            ),
          ),
        ],
      ),
    );
  }
}
