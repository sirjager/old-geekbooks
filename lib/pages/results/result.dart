import 'package:flutter/cupertino.dart';
import 'package:geekbooks/backend/calls/api_calls.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/page/pagination.dart';
import 'package:geekbooks/pages/results/view/gridview/gridpage.dart';
import 'package:geekbooks/pages/results/components/header.dart';
import 'package:geekbooks/pages/results/view/listview/listpage.dart';
import 'package:geekbooks/pages/results/components/pagestrip.dart';
import 'package:geekbooks/pages/results/components/paginationstrip.dart';
import 'package:lottie/lottie.dart';
import 'package:string_validator/string_validator.dart';

class SearchResults extends ConsumerWidget {
  final TextEditingController _jumper = TextEditingController();
  final FocusNode _focus = FocusNode();
  final ScrollController _scroll = ScrollController();

  Future<void> update(BuildContext context, String query, String pageNo,
      SizingInformation info) async {
    var pageination = context.read(pageinationProvider).pagination;

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
              child: Lottie.asset(MyAssets.pleasewait, height: R.h(info, 20)),
            ),
            barrierDismissible: false,
          );
          var pac = await ApiCalls().getPagePack(query, pageNo: pageNo);
          while (Get.isDialogOpen != null && Get.isDialogOpen!) {
            Get.back();
          }
          if (pac != null) {
            pageination = makePageNavigator(pac.info);
            context.read(pagePackProvider).latestPack(pac);
            context.read(pageinationProvider).latestPagination(pageination);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ResponsiveBuilder(
      builder: (context, info) {
        return Consumer(
          builder: (context, watch, child) {
            var latest = watch(pagePackProvider).pack;
            var pageination = watch(pageinationProvider).pagination;
            var view = watch(gridViewProvider);
            return Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: R.statusbarHeight(info)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    PageHeader(info, title: latest.query),
                    PageStrip(info, page: latest.info),
                    Expanded(
                      child: Container(
                        child: latest.books.length > 0
                            ? RawScrollbar(
                                thickness: pad * 0.75,
                                thumbColor: Colors.black54,
                                radius: Radius.circular(20),
                                controller: _scroll,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: pad),
                                  child: view.isGrid
                                      ? GridPage(
                                          info,
                                          query: latest.query,
                                          books: latest.books,
                                          scroll: _scroll,
                                        )
                                      : ListPage(info, books: latest.books),
                                ),
                              )
                            : Center(
                                child: KText("no results found for this query"),
                              ),
                      ),
                    ),
                    PaginationStrip(info,
                        page: latest.info,
                        pageination: pageination, prevOnTap: () {
                      if (pageination.hasPrev!) {
                        update(
                          context,
                          latest.query,
                          pageination.prevPageNumber.toString(),
                          info,
                        );
                      }
                    }, nextOnTap: () {
                      if (pageination.hasNext!) {
                        update(
                          context,
                          latest.query,
                          pageination.nextPageNumber.toString(),
                          info,
                        );
                      }
                    }, goOnTap: () {
                      _focus.unfocus();
                      update(
                        context,
                        latest.query,
                        _jumper.text,
                        info,
                      );
                    }),
                  ],
                ),
              ),
            );
          },
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
