import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geekbooks/ads/adprovider.dart';
import 'package:geekbooks/ads/adstate.dart';
import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/widgets/kImage/kimage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GridPage extends StatefulWidget {
  GridPage(
    this.info, {
    Key? key,
    required this.query,
    required this.books,
    required this.scroll,
  }) : super(key: key);
  final String query;
  final ScrollController scroll;
  final List<Book> books;
  final SizingInformation info;

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  late List listWithAds;

  @override
  void initState() {
    listWithAds = widget.books;
    // listWithAds = List.from(widget.books);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var adsState = context.read(adStateProvider);
  //   adsState.initialization.then((value) {
  //     insertAdsToList(adsState);
  //   });
  // }

  // void insertAdsToList(AdState adState) {
  //   setState(() {
  //     for (var i = listWithAds.length - 1; i >= 1; i -= 4) {
  //       listWithAds.insert(
  //         i,
  //         adState.createBannerAd(
  //           size: AdSize(
  //             height: R.h(widget.info, 38).toInt(),
  //             width: R.w(widget.info, 45).toInt(),
  //           ),
  //         )..load(),
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24);
    return StaggeredGridView.countBuilder(
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: listWithAds.length,
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.75),
      itemBuilder: (BuildContext context, int index) {
        var item = listWithAds[index];
        if (item is Book) {
          Book book = item;
          return Container(
            margin: EdgeInsets.all(R.w(widget.info, 2)),
            child: Container(
              child: GestureDetector(
                onTap: () =>
                    Get.to(() => BookView(book: book, books: widget.books)),
                child: Container(
                  child: Stack(
                    children: [
                      Consumer(
                        builder: (context, watch, child) {
                          var theme = watch(themeProvider);
                          return Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(top: R.h(widget.info, 12)),
                            decoration: theme.isDarkMode
                                ? BoxDecoration(
                                    color: Colors.white12, borderRadius: radius)
                                : BoxDecoration(
                                    color: randomLightColor(),
                                    borderRadius: radius),
                            padding: EdgeInsets.only(
                              top: R.h(widget.info, 15),
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
                                  size: R.f(widget.info, 8),
                                  maxLines: 2,
                                  color: theme.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  weight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  enableGoogleFonts: true,
                                  height: 1.2,
                                ),
                                SizedBox(height: pad),
                                KText(
                                  book.author ?? "",
                                  size: R.f(widget.info, 7),
                                  maxLines: 2,
                                  color: theme.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
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
                          height: R.h(widget.info, 26),
                          width: R.w(widget.info, 36),
                          imageURL: book.coverURL,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: AdWidget(ad: item as BannerAd),
          );
        }
      },
    );
  }
}
