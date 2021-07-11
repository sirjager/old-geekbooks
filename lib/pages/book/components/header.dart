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
    final _book = book;
    final size = 80;
    final top = expandedHeight - shrinkOffset - size / 2;

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
              left: 20,
              right: 20,
              child: buildFloating(shrinkOffset, _book, context, _theme),
            );
          },
        ),
        buildAppBar(shrinkOffset, _book, context),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset, Book book, BuildContext context) =>
      Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(pad),
              child: Icon(
                EvaIcons.arrowBackOutline,
                size: R.f(info, 25),
                color: Colors.black,
              ),
            ),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: pad * 2),
              child: KText(
                book.title,
                size: R.f(info, 11),
                weight: FontWeight.bold,
                enableGoogleFonts: true,
                color: Colors.red,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(pad),
                margin: const EdgeInsets.only(right: pad),
                child: Icon(
                  EvaIcons.bookmarkOutline,
                  size: R.f(info, 25),
                  color: Colors.black,
                ),
              ),
            ),
          ],
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
                    margin: const EdgeInsets.only(
                        left: pad * 2, right: pad * 2, bottom: pad * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          EvaIcons.arrowIosBack,
                          size: R.f(info, 25),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        Icon(
                          EvaIcons.share,
                          size: R.f(info, 25),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: pad * 2),
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
                    margin: EdgeInsets.only(top: pad),
                    padding: EdgeInsets.symmetric(horizontal: pad * 2),
                    child: Column(
                      children: [
                        book.title != "" && book.title != " "
                            ? KText(
                                book.title,
                                size: 15,
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
                                "by " + book.author!,
                                size: 12,
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
          elevation: 5,
          color: theme.isDarkMode ? Color(0xff202120) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(pad),
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
            size: 10,
            maxLines: 1,
            letterSpacing: 0.5,
            color: theme.isDarkMode ? Colors.white70 : Colors.red,
            enableGoogleFonts: true,
          ),
          const SizedBox(height: pad * 0.95),
          KText(
            value,
            size: 8,
            maxLines: 1,
            color: theme.isDarkMode ? Colors.white54 : Colors.black87,
            enableGoogleFonts: true,
          ),
        ],
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
