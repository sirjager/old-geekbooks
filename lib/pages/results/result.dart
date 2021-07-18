import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/backend/constants/api_strings.dart';
import 'package:geeklibrary/backend/export/backend_export.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/book/bookcard.dart';
import 'package:geeklibrary/models/page/page.dart';
import 'package:geeklibrary/models/page/pagination.dart';
import 'package:geeklibrary/pages/results/components/featurestrip.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/results/components/pagestrip.dart';
import 'package:geeklibrary/pages/results/components/pagination/go.dart';
import 'package:geeklibrary/pages/results/components/pagination/next.dart';
import 'package:geeklibrary/pages/results/components/pagination/prev.dart';
import 'package:geeklibrary/pages/results/view/listview/listpage.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
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

  bool delayed = false;

  late Pageination pageination;
  late PagePack newPack;

  void initState() {
    newPack = widget.pack;
    if (widget.pack.info != null) {
      pageination = makePageNavigator(widget.pack.info!);
    } else {}
    _focus.unfocus();
    _jumper.clear();
    super.initState();
  }

  @override
  void dispose() {
    _jumper.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> update(BuildContext context, String query, String pageNo,
      SizingInformation info) async {
    _jumper.clear();
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
              child: Lottie.asset(MyAssets.books, height: R.w(info, 35)),
            ),
            barrierDismissible: false,
          );
          var pac = await ApiCalls()
              .getPagePack(query, info, pageNo: pageNo.toString());

          setState(() {
            delayed = false;
            _jumper.clear();
            if (Get.isDialogOpen!) {
              Get.back();
            }
            _jumper.clear();
            if (pac != null && pac.info != null) {
              pageination = makePageNavigator(pac.info!);
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
          drawer: LeftDrawer(info),
          endDrawer: RightDrawer(info),
          body: !delayed
              ? Center(
                  child: Lottie.asset(MyAssets.books, height: R.w(info, 35),
                      onLoaded: (_) {
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      setState(() {
                        delayed = true;
                      });
                    });
                  }),
                )
              : Container(
                  padding: EdgeInsets.only(top: R.statusbarHeight(info)),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      PageHeader(info, title: query),
                      PageStrip(info, page: pageInfo),
                      FeatureStrip(info),
                      Expanded(
                        child: Container(
                          child: _books.length > 0
                              ? Consumer(
                                  builder: (context, watch, child) {
                                    var view = watch(gridViewProvider);
                                    var scroll = watch(scrollProvider).scroll;
                                    return RawScrollbar(
                                      thickness: pad * 0.75,
                                      thumbColor: Colors.black54,
                                      radius: Radius.circular(20),
                                      controller: scroll,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: pad),
                                        child: view.isGrid
                                            ? StaggeredGridView.countBuilder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 2,
                                                itemCount: _books.length,
                                                controller: scroll,
                                                staggeredTileBuilder: (index) =>
                                                    StaggeredTile.count(
                                                        1, 1.80),
                                                itemBuilder:
                                                    (BuildContext context,
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
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child:
                                      KText("no results found for this query"),
                                ),
                        ),
                      ),
                      pageInfo == null
                          ? Container()
                          : Container(
                              height: R.h(info, 11),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(35)),
                              ),
                              margin: const EdgeInsets.only(bottom: pad),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    margin: EdgeInsets.symmetric(
                                        horizontal: R.w(info, 4)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(pad),
                                          child: Consumer(
                                            builder: (context, watch, child) {
                                              var isDarkMode =
                                                  watch(themeProvider)
                                                      .isDarkMode;
                                              return KText(
                                                "jump to page",
                                                size: R.f(info, 9),
                                                weight: FontWeight.bold,
                                                color: isDarkMode
                                                    ? XColors.grayColor
                                                    : XColors.darkColor,
                                              );
                                            },
                                          ),
                                        ),
                                        Consumer(
                                          builder: (context, watch, child) {
                                            var _jumper = watch(jumperProvider)
                                                .pageNoController;
                                            return Row(
                                              children: [
                                                Container(
                                                  width: R.w(info, 25),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: pad),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          child: Consumer(
                                                            builder: (context,
                                                                watch, child) {
                                                              var isDarkMode =
                                                                  watch(themeProvider)
                                                                      .isDarkMode;
                                                              return CupertinoTextField(
                                                                decoration: isDarkMode
                                                                    ? BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: XColors
                                                                            .deepDark)
                                                                    : null,
                                                                autofocus:
                                                                    false,
                                                                controller:
                                                                    _jumper,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: R.f(
                                                                      info, 14),
                                                                  color: isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  bool isint =
                                                                      isInt(
                                                                          value);
                                                                  if (isint) {
                                                                    var i = int
                                                                        .parse(
                                                                            value);
                                                                    if (i < 1 ||
                                                                        i > pageination.totalPageNumber) {
                                                                      _jumper
                                                                          .clear();
                                                                      _focus
                                                                          .unfocus();
                                                                      Kui()
                                                                          .toast(
                                                                        context,
                                                                        "enter value between 1 to ${pageination.totalPageNumber.toString()}",
                                                                        textColor:
                                                                            Colors.red,
                                                                        backgroundColor:
                                                                            Theme.of(context).scaffoldBackgroundColor,
                                                                      );
                                                                    }
                                                                  } else {
                                                                    _jumper
                                                                        .clear();
                                                                    _focus
                                                                        .unfocus();
                                                                    Kui().toast(
                                                                      context,
                                                                      "enter a valid number",
                                                                      textColor:
                                                                          Colors
                                                                              .red,
                                                                      backgroundColor:
                                                                          Theme.of(context)
                                                                              .scaffoldBackgroundColor,
                                                                    );
                                                                  }
                                                                },
                                                                placeholder:
                                                                    pageInfo
                                                                        .currentPage,
                                                                placeholderStyle:
                                                                    TextStyle(
                                                                  fontSize: R.f(
                                                                      info, 14),
                                                                  color: isDarkMode
                                                                      ? XColors
                                                                          .grayText
                                                                          .withOpacity(
                                                                              0.3)
                                                                      : XColors
                                                                          .darkColor
                                                                          .withOpacity(
                                                                              0.3),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                maxLength: 3,
                                                                maxLines: 1,
                                                                maxLengthEnforcement:
                                                                    MaxLengthEnforcement
                                                                        .enforced,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: pad),
                                                        child: KText(
                                                          "/ ${pageInfo.totalPages}",
                                                          size: 14,
                                                          weight:
                                                              FontWeight.bold,
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
