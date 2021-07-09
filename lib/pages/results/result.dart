import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geekbooks/backend/calls/api_calls.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/backend/functions/math/colors_genrator.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/core/dialog/dialogs.dart';

import 'package:geekbooks/export/export.dart';

import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/page/pagination.dart';
import 'package:geekbooks/pages/view/view.dart';

import 'package:geekbooks/widgets/kImage/kimage.dart';
import 'package:lottie/lottie.dart';
import 'package:string_validator/string_validator.dart';

class SearchResults extends StatefulWidget {
  const SearchResults(this.pack, {Key? key}) : super(key: key);
  final PagePack pack;
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final TextEditingController _jumper = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool isGridView = true;
  final ScrollController _scroll = ScrollController();
  late Pageination pageination;
  late PagePack newPack;
  @override
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

  bool toggleView() {
    setState(() => isGridView = !isGridView);
    return !isGridView;
  }

  void update(
      query, pageNo, ThemeProvider theme, SizingInformation info) async {
    if (query != null && query.toString().length > 0) {
      bool isint = isInt(pageNo);
      if (isint) {
        var i = int.parse(pageNo);
        if (i > 0 && i <= pageination.totalPageNumber) {
          Get.dialog(
            Dialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Lottie.asset(MyAssets.pleasewait, height: R.h(info, 20)),
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
    final result = newPack.books;
    final page = newPack.info;

    return ResponsiveBuilder(
      builder: (context, info) {
        return Consumer(
          builder: (context, watch, child) {
            final _theme = watch(themeProvider);

            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            height: R.h(info, 2),
                            color: Colors.greenAccent[200],
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                KText(
                                  "${page.totalFiles} results found",
                                  size: R.f(info, 8),
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                VerticalDivider(color: Colors.black),
                                KText(
                                  "showing ${page.showingResultsFrom.toString()} - ${page.showingResultsTo.toString()}",
                                  size: R.f(info, 8),
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                VerticalDivider(color: Colors.black),
                                KText(
                                  "page : ${page.currentPage}",
                                  size: R.f(info, 8),
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: result.length > 0
                                  ? RawScrollbar(
                                      thickness: pad * 0.75,
                                      thumbColor: Colors.black54,
                                      radius: Radius.circular(20),
                                      isAlwaysShown: true,
                                      controller: _scroll,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: pad),
                                        child: isGridView
                                            ? StaggeredGridView.countBuilder(
                                                controller: _scroll,
                                                itemCount: result.length,
                                                staggeredTileBuilder: (index) =>
                                                    StaggeredTile.count(
                                                        1, 1.75),
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 2,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var book = result[index];
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            pad / 2),
                                                    child: InkWell(
                                                      splashColor: Colors
                                                          .greenAccent[200],
                                                      highlightColor: Colors
                                                          .greenAccent[200],
                                                      onTap: () => Get.to(
                                                        () => View(
                                                            id: book.id!,
                                                            books: result),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Container(
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: R.w(
                                                                          info,
                                                                          20)),
                                                              decoration: _theme
                                                                      .isDarkMode
                                                                  ? BoxDecoration(
                                                                      color: Colors
                                                                          .white12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    )
                                                                  : BoxDecoration(
                                                                      color:
                                                                          randomLightColor(),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                    ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: R.w(
                                                                    info, 32),
                                                                left: pad,
                                                                right: pad,
                                                                bottom: pad,
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  KText(
                                                                    book.title ??
                                                                        "",
                                                                    size: R.f(
                                                                        info,
                                                                        8),
                                                                    maxLines: 3,
                                                                    color: _theme.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    enableGoogleFonts:
                                                                        true,
                                                                    height: 1.2,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          pad *
                                                                              2),
                                                                  KText(
                                                                    book.author ??
                                                                        "",
                                                                    size: R.f(
                                                                        info,
                                                                        6),
                                                                    maxLines: 2,
                                                                    color: _theme.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    enableGoogleFonts:
                                                                        true,
                                                                    height: 1.2,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: KImage(
                                                                radius: pad * 2,
                                                                height: R.w(
                                                                    info, 56),
                                                                width: R.w(
                                                                    info, 36),
                                                                imageURL: book
                                                                    .coverURL,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: result.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var book = result[index];
                                                  return buildRowCard(info,
                                                      book, _theme, result);
                                                },
                                              ),
                                      ),
                                    )
                                  : Center(
                                      child: KText(
                                          "no results found for this query"),
                                    ),
                            ),
                          ),
                          Container(
                            height: R.h(info, 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(35)),
                            ),
                            margin: const EdgeInsets.only(bottom: pad),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                pageination.hasPrev!
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: pad),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(pad),
                                              child: KText(
                                                "previous",
                                                size: 10,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            KClickable(
                                              height: R.h(info, 5),
                                              width: R.w(info, 16),
                                              onPressed: () {
                                                if (pageination.hasPrev!) {
                                                  update(
                                                    query,
                                                    pageination.prevPageNumber
                                                        .toString(),
                                                    _theme,
                                                    info,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                EvaIcons.arrowLeft,
                                                color: Colors.black,
                                              ),
                                              topDeco: G.green2GradBannerDeco,
                                              bottomDeco: G.blackGradButtonDeco,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: pad),
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
                                                        child:
                                                            CupertinoTextField(
                                                          autofocus: false,
                                                          controller: _jumper,
                                                          style: TextStyle(
                                                            fontSize:
                                                                R.w(info, 14),
                                                            color: _theme
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                          ),
                                                          onChanged: (value) {
                                                            bool isint =
                                                                isInt(value);
                                                            if (isint) {
                                                              var i = int.parse(
                                                                  value);
                                                              if (i < 1 ||
                                                                  i >
                                                                      pageination
                                                                          .totalPageNumber) {
                                                                _jumper.clear();
                                                                _focus
                                                                    .unfocus();
                                                                Kui().toast(
                                                                  context,
                                                                  "enter value between 1 to ${pageination.totalPageNumber.toString()}",
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                  backgroundColor:
                                                                      Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor,
                                                                );
                                                              }
                                                            } else {
                                                              _jumper.clear();
                                                              _focus.unfocus();
                                                              Kui().toast(
                                                                context,
                                                                "enter a valid number",
                                                                textColor:
                                                                    Colors.red,
                                                                backgroundColor:
                                                                    Theme.of(
                                                                            context)
                                                                        .scaffoldBackgroundColor,
                                                              );
                                                            }
                                                          },
                                                          placeholder:
                                                              page.currentPage,
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          maxLength: 3,
                                                          maxLines: 1,
                                                          maxLengthEnforcement:
                                                              MaxLengthEnforcement
                                                                  .enforced,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: pad),
                                                      child: KText(
                                                        "/ ${page.totalPages}",
                                                        size: 14,
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              KClickable(
                                                height: R.h(info, 4),
                                                width: R.w(info, 10),
                                                onPressed: () {
                                                  _focus.unfocus();
                                                  update(
                                                    query,
                                                    _jumper.text,
                                                    _theme,
                                                    info,
                                                  );
                                                },
                                                child: KText(
                                                  "go",
                                                  size: 11,
                                                  weight: FontWeight.bold,
                                                ),
                                                topDeco: G.redGradBannerDeco,
                                                bottomDeco:
                                                    G.blackGradButtonDeco,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                pageination.hasNext!
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: pad),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(pad),
                                              child: KText(
                                                "next",
                                                size: 10,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                            KClickable(
                                              height: R.h(info, 5),
                                              width: R.w(info, 16),
                                              onPressed: () {
                                                if (pageination.hasNext!) {
                                                  update(
                                                    query,
                                                    pageination.nextPageNumber
                                                        .toString(),
                                                    _theme,
                                                    info,
                                                  );
                                                }
                                              },
                                              child: Icon(
                                                EvaIcons.arrowRight,
                                                color: Colors.black,
                                              ),
                                              topDeco: G.green2GradBannerDeco,
                                              bottomDeco: G.blackGradButtonDeco,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildRowCard(SizingInformation info, Book book, ThemeProvider theme,
      List<Book> books) {
    return Container(
      decoration: theme.isDarkMode
          ? BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(24),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, offset: Offset(1, 1), blurRadius: 1),
              ],
            ),
      padding: const EdgeInsets.all(pad),
      margin: const EdgeInsets.all(pad),
      child: InkWell(
        onTap: () => Get.to(
          () => View(id: book.id!, books: books),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: KImage(
                  radius: 10,
                  height: R.w(info, 30),
                  width: R.w(info, 20),
                  imageURL: book.coverURL,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: pad / 2),
                margin: const EdgeInsets.symmetric(vertical: pad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      book.title ?? "",
                      size: 15,
                      maxLines: 4,
                      color: theme.isDarkMode ? Colors.white : Colors.blue,
                      weight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: pad * 2),
                    KText(
                      book.author!,
                      size: 10,
                      maxLines: 5,
                      color: theme.isDarkMode ? Colors.white54 : Colors.blue,
                      weight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  makePageNavigator(PageInfo info) {
    final int totalPages = int.parse(info.totalPages!);
    final int currentPageNumber = int.parse(info.currentPage!);
    final String currentPageUrl = info.currentPageUrl!;
    final bool hasNextPage = (currentPageNumber < totalPages) ? true : false;
    final bool hasPrevPage = (currentPageNumber > 1) ? true : false;
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
