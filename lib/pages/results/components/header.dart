import 'package:geeklibrary/export/export.dart';
import 'package:shimmer/shimmer.dart';

class PageHeader extends ConsumerWidget {
  const PageHeader(this.info, {Key? key, required this.title})
      : super(key: key);
  final SizingInformation info;
  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var view = watch(gridViewProvider);
    var isDarkMode = watch(themeProvider).isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: R.w(info, 5),
        vertical: R.h(info, 1.2),
      ),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: R.w(info, 10),
            width: R.w(info, 10),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
              onPressed: () => Get.back(),
              splashColor: Colors.transparent,
              icon: Icon(EvaIcons.arrowIosBack),
              color: isDarkMode ? XColors.grayText : XColors.darkColor1,
            ),
          ),
          SizedBox(width: R.w(info, 5)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer(
                builder: (context, watch, child) {
                  var theme = watch(themeProvider);
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () => view.toggleGrid(),
                        splashColor: Colors.transparent,
                        icon: Icon(
                            view.isGrid ? EvaIcons.gridOutline : EvaIcons.list),
                        color:
                            isDarkMode ? XColors.grayText : XColors.darkColor1,
                      ),
                      SizedBox(width: R.w(info, 1)),
                      InkWell(
                        borderRadius: BorderRadius.circular(R.w(info, 50)),
                        child: Shimmer.fromColors(
                          period: Duration(seconds: 5),
                          direction: ShimmerDirection.rtl,
                          highlightColor: theme.isDarkMode
                              ? Colors.amber
                              : XColors.darkColor,
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
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
