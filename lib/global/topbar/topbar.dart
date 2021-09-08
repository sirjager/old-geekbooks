import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class ScreenTopbar extends StatelessWidget {
  const ScreenTopbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 150.w,
            width: 150.w,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Consumer(
              builder: (context, watch, child) {
                var theme = watch(themeProvider);
                return InkWell(
                  borderRadius: BorderRadius.circular(100.w),
                  onTap: () => theme.setMode(!theme.isDarkMode),
                  child: Shimmer.fromColors(
                    period: Duration(seconds: 5),
                    direction: ShimmerDirection.rtl,
                    highlightColor:
                        theme.isDarkMode ? Colors.amber : XColors.darkColor,
                    baseColor: XColors.grayColor,
                    child: theme.isDarkMode
                        ? Icon(EvaIcons.sun)
                        : Icon(EvaIcons.moon),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
