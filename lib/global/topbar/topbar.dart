import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class ScreenTopbar extends StatelessWidget {
  const ScreenTopbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150.w,
            width: 150.w,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Consumer(
              builder: (context, watch, child) {
                var isDarkMode = watch(themeProvider).isDarkMode;
                return RotatedBox(
                  quarterTurns: 1,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () =>
                        context.read(drawerProvider).toggleDrawer(),
                    iconSize: 70.w,
                    icon: Icon(EvaIcons.barChartOutline),
                    color: isDarkMode ? XColors.grayText : XColors.darkColor1,
                  ),
                );
              },
            ),
          ),
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
