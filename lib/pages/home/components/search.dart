import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/backend/constants/api_strings.dart';
import 'package:geeklibrary/backend/dialog/dialog.dart';
import 'package:geeklibrary/backend/export/backend_export.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/page/page.dart';
import 'package:geeklibrary/models/page/pagination.dart';
import 'package:geeklibrary/pages/results/result.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';
import 'package:lottie/lottie.dart';

class Searchbar extends StatefulWidget {
  const Searchbar(this.focus, {Key? key}) : super(key: key);

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
          width: 900.w,
          child: CupertinoTextField(
            controller: _searchField,
            onSubmitted: (val) => searchQuery(val, theme),
            decoration: BoxDecoration(
              color: XColors.lightGray,
              borderRadius: BorderRadius.circular(100.w),
            ),
            padding: EdgeInsets.all(50.w),
            style: TextStyle(
              fontFamily: "MavenPro",
              fontWeight: FontWeight.w400,
              fontSize: 50.sp,
              letterSpacing: 1,
              color: Colors.black87,
            ),
            prefix: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child:
                  Icon(EvaIcons.search, color: XColors.grayText, size: 70.sp),
            ),
            placeholder: "type here to search",
            placeholderStyle: TextStyle(
              fontFamily: "MavenPro",
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              fontSize: 50.sp,
              color: XColors.grayText,
            ),
          ),
        );
      },
    );
  }

  searchQuery(String query, ThemeProvider theme) async {
    widget.focus.unfocus();
    String string =
        query.removeAllWhitespace.toString().replaceAll(Str.space, Str.none);
    if (string.length > 0) {
      String col = context.read(searchOptionProvider).selected.value;
      UiDialog.showDialog(
        title: "",
        lottie: MyAssets.check,
        actionTitle: "",
        child: FutureBuilder<PagePack?>(
          future: ApiCalls().getPagePack(query, col: col),
          builder: (context, AsyncSnapshot<PagePack?> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                height: 500.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Lottie.asset(MyAssets.pleasewait, width: 500.w),
              );
            } else {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (!snapshot.hasData) {
                return Center(child: Text("No data found"));
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  PagePack pack = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.all(pad),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(MyAssets.check, height: 350.w),
                        KLeafButton(
                          onPressed: () {
                            if (Get.isDialogOpen!) Get.back();
                            Get.to(() => SearchResults(pack: pack));
                          },
                          color1: theme.isDarkMode
                              ? XColors.darkColor
                              : Colors.greenAccent[100]!,
                          color2: theme.isDarkMode
                              ? XColors.darkColor2
                              : Colors.greenAccent[200]!,
                          height: 150.h,
                          width: 350.w,
                          child: KText(
                            "continue",
                            font: "Poppins",
                            size: 40.sp,
                            color: theme.isDarkMode
                                ? XColors.darkText
                                : XColors.darkColor2,
                            weight: FontWeight.bold,
                          ),
                          icon: Ionicons.arrow_forward_circle,
                          iconColor: theme.isDarkMode
                              ? XColors.darkText
                              : XColors.darkColor2,
                        ),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text("Some Error Occured"));
                }
              } else {
                log.e("\n\n Page Return Null \n\n");
                while (Get.isDialogOpen != null && Get.isDialogOpen!) {
                  Get.back();
                }
                UiDialog.showDialog(
                  title: "Search Complete",
                  lottie: MyAssets.notfound1,
                  actionTitle: "Okay",
                );
                return Container();
              }
            }
          },
        ),
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
