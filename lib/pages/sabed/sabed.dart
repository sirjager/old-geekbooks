import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/global/book/bookcard.dart';
import 'package:geeklibrary/pages/results/components/featurestrip.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/results/view/listpage.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:lottie/lottie.dart';

class SabedOffline extends StatefulWidget {
  const SabedOffline({Key? key}) : super(key: key);

  @override
  SabedOfflineState createState() => SabedOfflineState();
}

class SabedOfflineState extends State<SabedOffline> {
  bool delayed = false;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: XColors.grayColor,
        ),
        padding: EdgeInsets.all(30.w),
        child: InkWell(
          onTap: () {
            var scroll = context.read(scrollProvider).scroll;
            scroll.animateTo(
              scroll.position.minScrollExtent,
              duration: Duration(seconds: 4),
              curve: Curves.fastOutSlowIn,
            );
          },
          child: Icon(
            EvaIcons.arrowUpwardOutline,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: ApiCalls.getSabed(),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: Lottie.asset(
                MyAssets.books,
                height: 350.w,
              ),
            );
          } else {
            if (!snapshot.hasData) {
              return Text("It's Empty Here");
            } else if (snapshot.hasError) {
              return Text("Something Went Wrong");
            } else if (snapshot.hasData) {
              final List<Book> books = snapshot.data!;
              return Container(
                padding: EdgeInsets.only(top: 30.h),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ResultHeader(title: "Saved Books"),
                    FeatureStrip(),
                    Expanded(
                      child: Container(
                        child: books.length > 0
                            ? Consumer(
                                builder: (context, watch, child) {
                                  var scroll = watch(scrollProvider).scroll;
                                  var theme = watch(themeProvider).isDarkMode;
                                  return RawScrollbar(
                                    thickness: 30.w,
                                    thumbColor: theme
                                        ? XColors.lightColor1
                                        : XColors.darkColor1,
                                    radius: Radius.circular(20),
                                    controller: scroll,
                                    isAlwaysShown: true,
                                    child: Consumer(
                                      builder: (context, watch, child) {
                                        var view = watch(gridViewProvider);
                                        return Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            left: 30.w,
                                            right: 60.w,
                                          ),
                                          child: view.isGrid
                                              ? StaggeredGridView.countBuilder(
                                                  physics:
                                                      ClampingScrollPhysics(),
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 2,
                                                  itemCount: books.length,
                                                  controller: scroll,
                                                  staggeredTileBuilder:
                                                      (index) =>
                                                          StaggeredTile.count(
                                                              1, 1.80),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var book = books[index];
                                                    return BookCard(
                                                        book: book,
                                                        books: books);
                                                  },
                                                )
                                              : ListPage(books: books),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            : Center(child: KText("No Offline")),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text("has Code");
            }
          }
        },
      ),
    );
  }
}
