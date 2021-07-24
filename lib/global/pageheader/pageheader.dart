import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class PageHeader extends ConsumerWidget {
  const PageHeader({Key? key, required this.title, this.enableDarkMode = false})
      : super(key: key);
  final String title;
  final bool enableDarkMode;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    return Container(
      margin:
          EdgeInsets.only(left: 50.w, right: 50.w, top: 120.h, bottom: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120.w,
            width: 120.w,
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
              onPressed: () => Get.back(),
              splashColor: Colors.transparent,
              icon: Icon(EvaIcons.arrowIosBack),
              iconSize: 50.w,
              color: isDarkMode ? XColors.grayText : XColors.darkColor1,
            ),
          ),
          SizedBox(width: 40.w),
          Consumer(
            builder: (context, watch, child) {
              var isDarkMode = watch(themeProvider).isDarkMode;
              return KText(
                title,
                font: "MavenPro",
                letterSpacing: 1,
                size: 100.sp,
                weight: FontWeight.w600,
                color: isDarkMode ? XColors.grayColor : Color(0xff555555),
              );
            },
          ),
          Spacer(),
          if (enableDarkMode)
            Consumer(
              builder: (context, watch, child) {
                var theme = watch(themeProvider);
                return Container(
                  height: 120.w,
                  width: 120.w,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.w),
                    child: Shimmer.fromColors(
                      period: Duration(seconds: 5),
                      direction: ShimmerDirection.rtl,
                      highlightColor:
                          theme.isDarkMode ? Colors.amber : XColors.darkColor,
                      baseColor: XColors.grayColor,
                      child: IconButton(
                        onPressed: () => theme.setMode(!theme.isDarkMode),
                        splashColor: Colors.transparent,
                        icon: theme.isDarkMode
                            ? Icon(EvaIcons.sun)
                            : Icon(EvaIcons.moon),
                        color:
                            isDarkMode ? XColors.grayText : XColors.darkColor1,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
