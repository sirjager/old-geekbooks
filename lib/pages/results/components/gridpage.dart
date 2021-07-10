import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/pages/view/view.dart';
import 'package:geekbooks/widgets/kImage/kimage.dart';

// GridPage(info,
//                                           books: result, scroll: _scroll)

class GridPage extends StatelessWidget {
  const GridPage(this.info,
      {Key? key, required this.books, required this.scroll})
      : super(key: key);
  final ScrollController scroll;
  final List<Book> books;
  final SizingInformation info;
  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24);
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: books.length,
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.75),
      itemBuilder: (BuildContext context, int index) {
        final Book book = books[index];
        return Container(
          margin: EdgeInsets.all(R.w(info, 2)),
          child: InkWell(
            splashColor: Colors.greenAccent[200],
            highlightColor: Colors.greenAccent[200],
            borderRadius: BorderRadius.circular(15),
            onTap: () => Get.to(() => View(id: book.id!, books: books)),
            child: Container(
              child: Stack(
                children: [
                  Consumer(
                    builder: (context, watch, child) {
                      var theme = watch(themeProvider);
                      return Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: R.h(info, 10)),
                        decoration: theme.isDarkMode
                            ? BoxDecoration(
                                color: Colors.white12, borderRadius: radius)
                            : BoxDecoration(
                                color: randomLightColor(),
                                borderRadius: radius),
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
                              book.title ?? "",
                              size: R.f(info, 8),
                              maxLines: 3,
                              color: theme.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              weight: FontWeight.bold,
                              enableGoogleFonts: true,
                              height: 1.2,
                            ),
                            SizedBox(height: pad * 2),
                            KText(
                              book.author ?? "",
                              size: R.f(info, 6),
                              maxLines: 2,
                              color: theme.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              weight: FontWeight.bold,
                              enableGoogleFonts: true,
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
                      height: R.w(info, 56),
                      width: R.w(info, 36),
                      imageURL: book.coverURL,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
