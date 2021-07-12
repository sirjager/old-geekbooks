import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geekbooks/ads/adprovider.dart';
import 'package:geekbooks/ads/adstate.dart';
import 'package:geekbooks/backend/calls/api_calls.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/core/dialog/dialogs.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/global/book/bookcard.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/page/pagination.dart';
import 'package:geekbooks/pages/results/components/header.dart';
import 'package:geekbooks/pages/results/components/pagestrip.dart';
import 'package:geekbooks/pages/results/components/pagination/go.dart';
import 'package:geekbooks/pages/results/components/pagination/next.dart';
import 'package:geekbooks/pages/results/components/pagination/prev.dart';
import 'package:geekbooks/pages/results/view/listview/listpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:string_validator/string_validator.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key, required this.pack}) : super(key: key);
  final PagePack pack;
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final TextEditingController _jumper = TextEditingController();
  final FocusNode _focus = FocusNode();
  final ScrollController _scroll = ScrollController();

  late Pageination pageination;
  late PagePack newPack;

  void initState() {
    newPack = widget.pack;
    pageination = makePageNavigator(widget.pack.info);
    _focus.unfocus();
    _jumper.clear();
    super.initState();
  }

  @override
  void dispose() {
    _jumper.dispose();
    _focus.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> update(BuildContext context, String query, String pageNo,
      SizingInformation info) async {
    if (query.length > 0) {
      bool isint = isInt(pageNo);
      if (isint) {
        var i = int.parse(pageNo);
        if (i > 0 && i <= pageination.totalPageNumber) {
          Get.dialog(
            Dialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Lottie.asset(MyAssets.pleasewait, height: R.h(info, 35)),
            ),
            barrierDismissible: false,
          );
          var pac =
              await ApiCalls().getPagePack(query, pageNo: pageNo.toString());

          setState(() {
            if (Get.isDialogOpen!) {
              Get.back();
            }
            if (pac != null) {
              pageination = makePageNavigator(pac.info);
              newPack = pac;
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = newPack.query;
    final _books = newPack.books;
    final pageInfo = newPack.info;
    return ResponsiveBuilder(
      builder: (context, info) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: R.statusbarHeight(info)),
            alignment: Alignment.center,
            child: Column(
              children: [
                PageHeader(info, title: query),
                PageStrip(info, page: pageInfo),
                Expanded(
                  child: Container(
                    child: _books.length > 0
                        ? RawScrollbar(
                            thickness: pad * 0.75,
                            thumbColor: Colors.black54,
                            radius: Radius.circular(20),
                            controller: _scroll,
                            child: Consumer(
                              builder: (context, watch, child) {
                                var view = watch(gridViewProvider);
                                watch(pagePackProvider);
                                return Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: pad),
                                  child: view.isGrid
                                      ? StaggeredGridView.countBuilder(
                                          physics: ClampingScrollPhysics(),
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          itemCount: _books.length,
                                          staggeredTileBuilder: (index) =>
                                              StaggeredTile.count(1, 1.75),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var book = _books[index];
                                            return BookCard(
                                              info,
                                              book: book,
                                              books: newPack.books,
                                            );
                                          },
                                        )
                                      : ListPage(info, books: _books),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: KText("no results found for this query"),
                          ),
                  ),
                ),
                Container(
                  height: R.h(info, 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  margin: const EdgeInsets.only(bottom: pad),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PreviousButton(
                        info,
                        hasPrev: pageination.hasPrev!,
                        onPressed: () {
                          if (pageination.hasPrev!) {
                            update(
                              context,
                              query,
                              pageination.prevPageNumber.toString(),
                              info,
                            );
                          }
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: pad),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(pad),
                              child: KText(
                                "jump to page",
                                size: 10,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Consumer(
                              builder: (context, watch, child) {
                                var _jumper =
                                    watch(jumperProvider).pageNoController;
                                return Row(
                                  children: [
                                    Container(
                                      width: R.w(info, 25),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: pad),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: CupertinoTextField(
                                                autofocus: false,
                                                controller: _jumper,
                                                style: TextStyle(
                                                  fontSize: R.f(info, 14),
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                onChanged: (value) {
                                                  bool isint = isInt(value);
                                                  if (isint) {
                                                    var i = int.parse(value);
                                                    if (i < 1 ||
                                                        i >
                                                            pageination
                                                                .totalPageNumber) {
                                                      _jumper.clear();
                                                      _focus.unfocus();
                                                      Kui().toast(
                                                        context,
                                                        "enter value between 1 to ${pageination.totalPageNumber.toString()}",
                                                        textColor: Colors.red,
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .scaffoldBackgroundColor,
                                                      );
                                                    }
                                                  } else {
                                                    _jumper.clear();
                                                    _focus.unfocus();
                                                    Kui().toast(
                                                      context,
                                                      "enter a valid number",
                                                      textColor: Colors.red,
                                                      backgroundColor: Theme.of(
                                                              context)
                                                          .scaffoldBackgroundColor,
                                                    );
                                                  }
                                                },
                                                placeholder:
                                                    pageInfo.currentPage,
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 3,
                                                maxLines: 1,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: pad),
                                            child: KText(
                                              "/ ${pageInfo.totalPages}",
                                              size: 14,
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GoButton(
                                      info,
                                      onPressed: () {
                                        _focus.unfocus();
                                        update(
                                          context,
                                          newPack.query,
                                          _jumper.text,
                                          info,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      NextButton(
                        info,
                        hasNext: pageination.hasNext!,
                        onPressed: () {
                          if (pageination.hasNext!) {
                            update(
                              context,
                              query,
                              pageination.nextPageNumber.toString(),
                              info,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  makePageNavigator(PageInfo info) {
    int totalPages = int.parse(info.totalPages!);
    int currentPageNumber = int.parse(info.currentPage!);
    String currentPageUrl = info.currentPageUrl!;
    bool hasNextPage = (currentPageNumber < totalPages) ? true : false;
    bool hasPrevPage = (currentPageNumber > 1) ? true : false;
    int? nextPageNumber;
    String? nextPageUrl;
    int? prevPageNumber;
    String? prevPageUrl;
    if (hasNextPage) {
      nextPageNumber = currentPageNumber + 1;
      nextPageUrl =
          ApiLenks.genisUrl + info.sortSample! + nextPageNumber.toString();
    } else {}
    if (hasPrevPage) {
      prevPageNumber =
          currentPageNumber > 0 ? currentPageNumber - 1 : currentPageNumber;
      prevPageUrl =
          ApiLenks.genisUrl + info.sortSample! + prevPageNumber.toString();
    } else {}

    return Pageination(
      currentPageNumber: currentPageNumber,
      totalPageNumber: totalPages,
      currentPageUrl: currentPageUrl,
      hasNext: hasNextPage,
      hasPrev: hasPrevPage,
      nextPageNumber: nextPageNumber,
      prevPageNumber: prevPageNumber,
      nextPageURL: nextPageUrl,
      prevPageUrl: prevPageUrl,
    );
  }
}
