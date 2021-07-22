import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class ResultHeader extends ConsumerWidget {
  const ResultHeader({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var view = watch(gridViewProvider);
    var isDarkMode = watch(themeProvider).isDarkMode;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: KText(
                title,
                color: isDarkMode ? XColors.grayColor : XColors.darkColor1,
              ),
            ),
          ),
          Consumer(
            builder: (context, watch, child) {
              var theme = watch(themeProvider);
              return Row(
                children: [
                  Container(
                    height: 120.w,
                    width: 120.w,
                    child: IconButton(
                      onPressed: () => view.toggleGrid(),
                      splashColor: Colors.transparent,
                      icon: Icon(
                          view.isGrid ? EvaIcons.gridOutline : EvaIcons.list),
                      color: isDarkMode ? XColors.grayText : XColors.darkColor1,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
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
                          color: isDarkMode
                              ? XColors.grayText
                              : XColors.darkColor1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
