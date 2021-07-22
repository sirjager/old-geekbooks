import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/page/page.dart';

class PageStrip extends ConsumerWidget {
  const PageStrip({Key? key, required this.page}) : super(key: key);
  final PageInfo? page;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;
    if (page == null) {
      return Container();
    } else {
      return Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        alignment: Alignment.center,
        color: isDarkMode ? XColors.darkColor2 : XColors.darkGray,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      page!.totalFiles.toString(),
                      size: 35.sp,
                      weight: FontWeight.bold,
                      color: isDarkMode ? XColors.grayColor : Colors.black,
                    ),
                    KText(
                      "Results Found",
                      size: 35.sp,
                      weight: FontWeight.bold,
                      color: isDarkMode ? XColors.grayColor : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              thickness: 5.w,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KText(
                  "Page ",
                  size: 35.sp,
                  weight: FontWeight.bold,
                  color: isDarkMode ? XColors.grayColor : Colors.black,
                ),
                KText(
                  page!.currentPage.toString(),
                  size: 35.sp,
                  weight: FontWeight.bold,
                  color: isDarkMode ? XColors.grayColor : Colors.black,
                ),
              ],
            ),
            VerticalDivider(
              thickness: 5.w,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    "Showing from ",
                    size: 35.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayColor : Colors.black,
                  ),
                  KText(
                    page!.showingResultsFrom.toString(),
                    size: 35.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayColor : Colors.black,
                  ),
                  KText(
                    "-",
                    size: 35.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayColor : Colors.black,
                  ),
                  KText(
                    page!.showingResultsTo.toString(),
                    size: 35.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode ? XColors.grayColor : Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
