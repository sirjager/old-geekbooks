import 'package:geeklibrary/backend/functions/math/colors_genrator.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/page/page.dart';

class PageStrip extends ConsumerWidget {
  const PageStrip(this.info, {Key? key, required this.page}) : super(key: key);
  final PageInfo page;
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isDarkMode = watch(themeProvider).isDarkMode;

    return Container(
      height: R.h(info, 2),
      padding: EdgeInsets.symmetric(horizontal: R.w(info, 5)),
      alignment: Alignment.center,
      color: isDarkMode ? XColors.darkColor2 : randomLightColor(),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    page.totalFiles.toString(),
                    size: R.f(info, 9),
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  KText(
                    "Results Found",
                    size: R.f(info, 9),
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KText(
                "Page ",
                size: R.f(info, 9),
                weight: FontWeight.bold,
                color: Colors.black,
              ),
              KText(
                page.currentPage.toString(),
                size: R.f(info, 9),
                weight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KText(
                  "Showing from ",
                  size: R.f(info, 9),
                  weight: FontWeight.bold,
                  color: Colors.black,
                ),
                KText(
                  page.showingResultsFrom.toString(),
                  size: R.f(info, 9),
                  weight: FontWeight.bold,
                  color: Colors.black,
                ),
                KText(
                  "-",
                  size: R.f(info, 9),
                  weight: FontWeight.bold,
                  color: Colors.black,
                ),
                KText(
                  page.showingResultsTo.toString(),
                  size: R.f(info, 9),
                  weight: FontWeight.bold,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
