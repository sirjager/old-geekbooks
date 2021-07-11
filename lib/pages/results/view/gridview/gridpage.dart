import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geekbooks/ads/adprovider.dart';
import 'package:geekbooks/ads/adstate.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/global/book/bookcard.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GridPage extends StatefulWidget {
  const GridPage(
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
  late List<Object> listWithAds;

  @override
  void initState() {
    listWithAds = List.from(widget.books);
    super.initState();
    // listWithAds = widget.books;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adsState = context.read(adStateProvider);
    adsState.initialization.then((value) {
      insertAdsToList(adsState);
    });
  }

  void insertAdsToList(AdState adState) {
    setState(() {
      for (var i = listWithAds.length - 1; i >= 1; i -= 4) {
        listWithAds.insert(
          i,
          adState.createBannerAd(
            size: AdSize(
              height: R.h(widget.info, 38).toInt(),
              width: R.w(widget.info, 45).toInt(),
            ),
          )..load(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: listWithAds.length,
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.75),
      itemBuilder: (BuildContext context, int index) {
        final item = listWithAds[index];
        if (item is Book) {
          final Book book = item;
          return BookCard(widget.info, book: book, books: widget.books);
        } else {
          return AdWidget(ad: item as BannerAd);
        }
      },
    );
  }
}
