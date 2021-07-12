import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/kImage/kimage.dart';
import 'package:geekbooks/widgets/kblur/kblur.dart';

class BookViewHeader extends SliverPersistentHeaderDelegate {
  final Book book;
  final SizingInformation info;
  final double expandedHeight;

  const BookViewHeader(this.info,
      {required this.expandedHeight, required this.book});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double value = 5;
    final double avg = (R.h(info, 1) + R.w(info, 1) / 100);
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
              left: R.w(info, 3),
              right: R.w(info, 3),
              child: buildFloating(shrinkOffset, _book, context, _theme),
            );
          },
        ),
        buildAppBar(shrinkOffset, _book, context),
        Positioned(
          top: R.h(info, 5),
          left: R.w(info, 4),
          right: R.w(info, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: R.w(info, 11),
                width: R.w(info, 11),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () => Get.back(),
                  iconSize: R.w(info, 5),
                  icon: Icon(EvaIcons.arrowIosBack),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              Container(
                height: R.w(info, 11),
                width: R.w(info, 11),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  iconSize: R.w(info, 5),
                  icon: Icon(EvaIcons.bellOutline),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
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
        // opacity: 0.10,
        child: Container(
          padding: EdgeInsets.only(top: R.statusbarHeight(info)),
          height: R.appbarHeight,
          color: Theme.of(context).scaffoldBackgroundColor,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: R.h(info, 3),
              horizontal: R.w(info, 17),
            ),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: KText(
                book.title + "        ",
                size: R.f(info, 13),
                weight: FontWeight.bold,
              ),
            ),
          ),
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
            imageURL: book.coverURL!,
          ),
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: pad),
                    ),
                    child: KImage(
                      fit: BoxFit.fill,
                      height: R.w(info, 44),
                      width: R.w(info, 31),
                      imageURL: book.coverURL!,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: R.h(info, 3)),
                    padding: EdgeInsets.symmetric(horizontal: pad * 2),
                    child: Column(
                      children: [
                        book.title != "" && book.title != " "
                            ? KText(
                                book.title,
                                size: R.f(info, 13),
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
                                size: R.f(info, 10),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(R.h(info, 1.5)),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: buildButton(
                        field: 'Year', value: book.year ?? "", theme: theme)),
                Container(
                    width: 1,
                    height: R.h(info, 4),
                    color: theme.isDarkMode ? Colors.white38 : Colors.black12),
                Expanded(
                    flex: 5,
                    child: buildButton(
                        field: 'Number of pages',
                        value: book.pages ?? "?" + " Pages",
                        theme: theme)),
                Container(
                    width: 1,
                    height: R.h(info, 4),
                    color: theme.isDarkMode ? Colors.white38 : Colors.black12),
                Expanded(
                    flex: 3,
                    child: buildButton(
                        field: 'Language',
                        value: book.language ?? "?",
                        theme: theme)),
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
            size: R.f(info, 8),
            maxLines: 1,
            letterSpacing: 0.5,
            color: theme.isDarkMode ? Colors.white70 : Colors.red,
            enableGoogleFonts: true,
          ),
          const SizedBox(height: pad * 0.95),
          KText(
            value,
            size: R.f(info, 8),
            maxLines: 1,
            color: theme.isDarkMode ? Colors.white54 : Colors.black87,
            enableGoogleFonts: true,
          ),
        ],
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + R.h(info, 6);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
