import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';

class BookCard extends ConsumerWidget {
  const BookCard(
    this.info, {
    Key? key,
    required this.book,
    required this.books,
  }) : super(key: key);
  final Book book;
  final List books;
  final SizingInformation info;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    bool blackNWhite = watch(blackNWhiteProvider).blackNWhite;
    final BorderRadius radius = BorderRadius.circular(24);
    return Container(
      margin: EdgeInsets.all(R.w(info, 2)),
      child: GestureDetector(
        onTap: () => Get.to(() => BookView(book: book, books: books)),
        child: Container(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: R.h(info, 12)),
                decoration: theme.isDarkMode
                    ? BoxDecoration(color: Colors.white12, borderRadius: radius)
                    : BoxDecoration(
                        color: randomLightColor(), borderRadius: radius),
                padding: EdgeInsets.only(
                  top: R.h(info, 15),
                  left: pad,
                  right: pad,
                  bottom: pad,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      book.title ?? "no title",
                      size: R.f(info, 9),
                      maxLines: 2,
                      color: theme.isDarkMode
                          ? XColors.grayColor
                          : XColors.darkColor,
                      weight: FontWeight.w900,
                      overflow: TextOverflow.ellipsis,
                      enableGoogleFonts: true,
                      height: 1.2,
                    ),
                    SizedBox(height: pad),
                    KText(
                      book.author ?? "",
                      size: R.f(info, 8),
                      maxLines: 2,
                      color: theme.isDarkMode
                          ? XColors.grayText
                          : XColors.darkColor,
                      weight: FontWeight.w700,
                      enableGoogleFonts: true,
                      overflow: TextOverflow.ellipsis,
                      height: 1.2,
                    ),
                    SizedBox(height: pad),
                    Row(
                      children: [
                        KText(
                          "Extension : ",
                          size: R.f(info, 8),
                          color: theme.isDarkMode
                              ? XColors.grayText
                              : XColors.darkColor,
                          weight: FontWeight.w600,
                          enableGoogleFonts: true,
                        ),
                        KText(
                          book.exten.toString(),
                          size: R.f(info, 8),
                          color: theme.isDarkMode
                              ? Colors.white
                              : XColors.darkColor,
                          weight: FontWeight.bold,
                          enableGoogleFonts: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: book.id + "result",
                  child: KImage(
                    borderRadius: BorderRadius.circular(20),
                    height: R.h(info, 26),
                    width: R.w(info, 36),
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
