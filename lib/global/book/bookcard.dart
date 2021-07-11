import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/kImage/kimage.dart';

class BookCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24);
    return Container(
      margin: EdgeInsets.all(R.w(info, 2)),
      child: InkWell(
        splashColor: Colors.greenAccent[200],
        highlightColor: Colors.greenAccent[200],
        borderRadius: BorderRadius.circular(15),
        onTap: () => Get.to(() => BookView(book: book, books: books)),
        child: Container(
          child: Stack(
            children: [
              Consumer(
                builder: (context, watch, child) {
                  var theme = watch(themeProvider);
                  return Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(top: R.h(info, 12)),
                    decoration: theme.isDarkMode
                        ? BoxDecoration(
                            color: Colors.white12, borderRadius: radius)
                        : BoxDecoration(
                            color: randomLightColor(), borderRadius: radius),
                    padding: EdgeInsets.only(
                      top: R.w(info, 32),
                      left: pad,
                      right: pad,
                      bottom: pad,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          book.title,
                          size: R.f(info, 8),
                          maxLines: 3,
                          color: theme.isDarkMode ? Colors.white : Colors.black,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          enableGoogleFonts: true,
                          height: 1.2,
                        ),
                        SizedBox(height: pad),
                        KText(
                          book.author ?? "",
                          size: R.f(info, 7),
                          maxLines: 2,
                          color: theme.isDarkMode ? Colors.white : Colors.black,
                          weight: FontWeight.bold,
                          enableGoogleFonts: true,
                          overflow: TextOverflow.ellipsis,
                          height: 1.2,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.topCenter,
                child: KImage(
                  radius: pad * 2,
                  height: R.h(info, 26),
                  width: R.w(info, 36),
                  imageURL: book.coverURL,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
