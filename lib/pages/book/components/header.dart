import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:geeklibrary/widgets/kblur/kblur.dart';
import 'package:shimmer/shimmer.dart';

class BookViewHeader extends SliverPersistentHeaderDelegate {
  final Book book;

  final double expandedHeight;

  const BookViewHeader({required this.expandedHeight, required this.book});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double value = 5;
    final double avg = (23.4.h + 10.8.w / 100);
    final _book = book;
    final top = expandedHeight - shrinkOffset - avg * value;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        buildBackground(shrinkOffset, _book, context),
        Consumer(
          builder: (context, watch, child) {
            final _theme = watch(themeProvider);
            return Positioned(
              top: top,
              left: 20.w,
              right: 20.w,
              child: buildFloating(shrinkOffset, _book, context, _theme),
            );
          },
        ),
        buildAppBar(shrinkOffset, _book, context),
        Positioned(
          top: 120.h,
          left: 50.w,
          right: 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer(
                builder: (context, watch, child) {
                  var darkmode = watch(themeProvider).isDarkMode;
                  return Container(
                    height: 120.w,
                    width: 120.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkmode ? Colors.white10 : Colors.black12,
                    ),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () => Get.back(),
                      iconSize: 60.sp,
                      icon: Icon(EvaIcons.arrowIosBack),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  );
                },
              ),
              Consumer(
                builder: (context, watch, child) {
                  var theme = watch(themeProvider);
                  return Container(
                    height: 120.w,
                    width: 120.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.isDarkMode ? Colors.white12 : Colors.black12,
                    ),
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
                        color: theme.isDarkMode
                            ? XColors.grayText
                            : XColors.darkColor1,
                        iconSize: 60.sp,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset, Book book, BuildContext context) =>
      Opacity(
        opacity: appear(shrinkOffset),
        child: Consumer(
          builder: (context, watch, child) {
            var darkMode = watch(themeProvider).isDarkMode;
            return Container(
              height: minExtent,
              padding: EdgeInsets.only(
                top: 90.h,
                left: 200.w,
                right: 200.w,
              ),
              decoration: BoxDecoration(
                color: darkMode
                    ? XColors.deepDark
                    : Theme.of(context).scaffoldBackgroundColor,
              ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: KText(
                    book.title ?? "" + "        ",
                    size: 50.sp,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget buildBackground(
          double shrinkOffset, Book book, BuildContext context) =>
      Opacity(
        opacity: disappear(shrinkOffset),
        child: KBlur(
          blur: 7.5,
          under: KImage(
            height: double.infinity,
            width: double.infinity,
            imageURL: book.coverURL,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(90.w)),
          ),
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 20.w),
                    ),
                    child: KImage(
                      height: 600.h,
                      width: 350.w,
                      imageURL: book.coverURL!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: 70.h),
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        book.title != "" && book.title != " "
                            ? KText(
                                book.title ?? "no title",
                                size: 55.sp,
                                maxLines: 1,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),
                        const SizedBox(height: pad),
                        book.author != null &&
                                book.author != "" &&
                                book.author != " "
                            ? KText(
                                book.author!,
                                size: 40.sp,
                                maxLines: 1,
                                color: Colors.white,
                                weight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildFloating(double shrinkOffset, Book book, BuildContext context,
          ThemeProvider theme) =>
      Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          elevation: 3,
          color: theme.isDarkMode ? Color(0xff202120) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.w)),
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: buildButton(
                        field: 'Year', value: book.year ?? "", theme: theme)),
                Container(
                    width: 1,
                    height: 90.h,
                    color: theme.isDarkMode ? Colors.white38 : Colors.black12),
                Expanded(
                    flex: 5,
                    child: buildButton(
                        field: 'Number of pages',
                        value: book.pages ?? "?" + " Pages",
                        theme: theme)),
                Container(
                    width: 1,
                    height: 90.h,
                    color: theme.isDarkMode ? Colors.white38 : Colors.black12),
                Expanded(
                    flex: 3,
                    child: buildButton(
                      field: 'Language',
                      value: book.language ?? "?",
                      theme: theme,
                    )),
              ],
            ),
          ),
        ),
      );

  Widget buildButton(
          {required String field,
          required String value,
          required ThemeProvider theme}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            field,
            size: 37.sp,
            maxLines: 1,
            letterSpacing: 0.5,
            color: theme.isDarkMode ? Colors.white70 : Colors.black87,
            enableGoogleFonts: true,
          ),
          SizedBox(height: 30.h),
          KText(
            value,
            size: 33.sp,
            maxLines: 1,
            color: theme.isDarkMode ? Colors.white54 : Colors.black87,
            enableGoogleFonts: true,
          ),
        ],
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 200.h + 100.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
