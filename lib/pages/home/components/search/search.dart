import 'package:flutter/cupertino.dart';
import 'package:geekbooks/backend/calls/api_calls.dart';
import 'package:geekbooks/backend/constants/api_strings.dart';
import 'package:geekbooks/backend/export/backend_export.dart';
import 'package:geekbooks/constants/numers/nums.dart';
import 'package:geekbooks/export/export.dart';
import 'package:geekbooks/models/page/page.dart';
import 'package:geekbooks/models/page/pagination.dart';
import 'package:geekbooks/pages/results/result.dart';
import 'package:geekbooks/widgets/kbuttons/kleaf_button.dart';
import 'package:lottie/lottie.dart';

class Searchbar extends StatefulWidget {
  const Searchbar(this.info, this.focus, {Key? key}) : super(key: key);
  final SizingInformation info;
  final FocusNode focus;

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _searchField = TextEditingController();

  String query = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var theme = watch(themeProvider);
        return Container(
          alignment: Alignment.center,
          width: R.w(widget.info, 85),
          child: CupertinoTextField(
            controller: _searchField,
            onSubmitted: (val) => searchQuery(val, theme, widget.info),
            decoration: BoxDecoration(
                color: XColors.lightGray,
                borderRadius: BorderRadius.circular(24)),
            padding: EdgeInsets.all(R.w(widget.info, 4)),
            style: TextStyle(
              fontFamily: "MavenPro",
              fontWeight: FontWeight.w400,
              fontSize: R.f(widget.info, 10),
              letterSpacing: 1,
              color: Colors.black87,
            ),
            prefix: Padding(
              padding: EdgeInsets.only(left: R.w(widget.info, 5)),
              child: Icon(
                EvaIcons.search,
                color: XColors.grayText,
                size: R.h(widget.info, 3.1),
              ),
            ),
            placeholder: "type here to search",
            placeholderStyle: TextStyle(
              fontFamily: "MavenPro",
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              fontSize: R.f(widget.info, 10),
              color: XColors.grayText,
            ),
          ),
        );
      },
    );
  }

  searchQuery(String query, ThemeProvider theme, SizingInformation info) async {
    widget.focus.unfocus();
    String string =
        query.removeAllWhitespace.toString().replaceAll(Str.space, Str.none);
    if (string.length > 0) {
      Get.dialog(
        Dialog(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: FutureBuilder<PagePack?>(
            future: ApiCalls().getPagePack(query),
            builder: (context, AsyncSnapshot<PagePack?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  PagePack pack = snapshot.data!;
                  context.read(pagePackProvider).latestPack(pack);
                  Pageination pagination = makePageNavigator(pack.info);
                  context
                      .read(pageinationProvider)
                      .latestPagination(pagination);
                  return Container(
                    padding: const EdgeInsets.all(pad),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(MyAssets.check, height: R.h(info, 25)),
                        KLeafButton(
                          onPressed: () {
                            if (Get.isDialogOpen!) Get.back();
                            Get.to(() => SearchResults(pack: pack));
                          },
                          height: R.w(info, 15),
                          width: R.w(info, 35),
                          child: KText(
                            "continue",
                            size: R.f(info, 10),
                          ),
                          icon: Ionicons.arrow_forward_circle,
                        ),
                        SizedBox(height: pad * 2),
                      ],
                    ),
                  );
                }
                print("page return Null");
              }
              return Container(
                height: R.w(info, 50),
                decoration: BoxDecoration(
                  color: theme.isDarkMode ? Colors.black45 : Colors.white,
                ),
                child: Lottie.asset(MyAssets.pleasewait),
              );
            },
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  Pageination makePageNavigator(PageInfo info) {
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
