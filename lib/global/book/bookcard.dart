import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class BookCard extends ConsumerWidget {
  const BookCard({
    Key? key,
    required this.book,
    required this.books,
  }) : super(key: key);
  final Book book;
  final List books;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    bool blackNWhite = watch(blackNWhiteProvider).blackNWhite;
    final BorderRadius radius = BorderRadius.circular(40.w);
    return Container(
      margin: EdgeInsets.all(20.w),
      child: GestureDetector(
        onTap: () => Get.to(() => BookView(book: book, books: books)),
        child: Container(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 275.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: theme.isDarkMode
                    ? BoxDecoration(
                        color: Colors.white12,
                        borderRadius: radius,
                      )
                    : BoxDecoration(
                        color: randomLightColor(), borderRadius: radius),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 275.w),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: KText(
                          book.title ?? "no title",
                          size: 35.sp,
                          maxLines: 3,
                          color: theme.isDarkMode
                              ? XColors.grayColor
                              : XColors.darkColor,
                          weight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                          enableGoogleFonts: true,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: KText(
                          book.author ?? "",
                          size: 30.sp,
                          maxLines: 2,
                          color: theme.isDarkMode
                              ? XColors.grayText
                              : XColors.darkColor,
                          weight: FontWeight.w700,
                          enableGoogleFonts: true,
                          overflow: TextOverflow.ellipsis,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            KText(
                              "Extension : ",
                              size: 30.sp,
                              color: theme.isDarkMode
                                  ? XColors.grayText
                                  : XColors.darkColor,
                              weight: FontWeight.w600,
                              enableGoogleFonts: true,
                            ),
                            SizedBox(width: 30.w),
                            KText(
                              book.exten.toString(),
                              size: 31.sp,
                              color: theme.isDarkMode
                                  ? Colors.white
                                  : XColors.darkColor,
                              weight: FontWeight.bold,
                              enableGoogleFonts: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: book.id + "result",
                  child: KImage(
                    borderRadius: BorderRadius.circular(25.w),
                    height: 550.w,
                    width: 375.w,
                    fit: BoxFit.fill,
                    imageURL: book.coverURL,
                    filterColor: blackNWhite
                        ? Colors.black87.withOpacity(0.6)
                        : Colors.transparent,
                    blendMode: blackNWhite ? BlendMode.multiply : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
