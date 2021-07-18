import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/zoom/zoom.dart';
import 'package:geeklibrary/screens/dashboard/components/drawer/left_drawer.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

class RiderProvider extends StatefulWidget {
  const RiderProvider(this.book, {Key? key}) : super(key: key);
  final Book book;

  @override
  _RiderProviderState createState() => _RiderProviderState();
}

class _RiderProviderState extends State<RiderProvider> {
  bool delayed = false;

  void openPage(String md5) async {
    final String _url = ApiCalls().makeGraberURL(md5);
    bool _canLaunch = await launch.canLaunch(_url);
    if (_canLaunch) {
      await launch.launch(_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Book book = widget.book;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: PageHeader(info,
                            title: "Go Back", disableAction: true),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Consumer(
                            builder: (context, watch, child) {
                              var isDarkMode = watch(themeProvider).isDarkMode;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(R.w(info, 5)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? XColors.grayColor
                                            : XColors.darkColor,
                                        borderRadius: BorderRadius.circular(27),
                                        border: Border.all(
                                          color: isDarkMode
                                              ? XColors.grayColor
                                              : XColors.darkColor,
                                          width: R.w(info, 1),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Get.to(() => ZoomView(
                                              img: book.coverURL!,
                                              tag: "zoomView",
                                            )),
                                        child: Hero(
                                          tag: "zoomView",
                                          child: Container(
                                            child: KImage(
                                              fit: BoxFit.fill,
                                              width: R.w(info, 50),
                                              height: R.w(info, 80),
                                              imageURL: book.coverURL,
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: R.w(info, 90),
                                    child: KText(
                                      book.title!,
                                      font: "MavenPro",
                                      size: R.f(info, 15),
                                      weight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      color: isDarkMode
                                          ? XColors.darkGray.withOpacity(0.7)
                                          : XColors.darkColor1.withOpacity(0.7),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: R.w(info, 5),
                                      vertical: R.h(info, 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        KText(
                                          'File Size : ',
                                          font: "MavenPro",
                                          size: R.f(info, 15),
                                          weight: FontWeight.w500,
                                          color: isDarkMode
                                              ? XColors.darkGray
                                                  .withOpacity(0.7)
                                              : XColors.darkColor1
                                                  .withOpacity(0.7),
                                        ),
                                        KText(
                                          XMath.convertBytesToMB(
                                                  book.fileSize) +
                                              ' MB',
                                          font: "MavenPro",
                                          size: R.f(info, 15),
                                          weight: FontWeight.w500,
                                          color: isDarkMode
                                              ? XColors.darkGray
                                                  .withOpacity(0.7)
                                              : XColors.darkColor1
                                                  .withOpacity(0.7),
                                        ),
                                        SizedBox(width: R.w(info, 5)),
                                        KText(
                                          'Extension : ',
                                          font: "MavenPro",
                                          size: R.f(info, 15),
                                          weight: FontWeight.w500,
                                          color: isDarkMode
                                              ? XColors.darkGray
                                                  .withOpacity(0.7)
                                              : XColors.darkColor1
                                                  .withOpacity(0.7),
                                        ),
                                        KText(
                                          book.exten ?? "unknown",
                                          font: "MavenPro",
                                          size: R.f(info, 15),
                                          weight: FontWeight.w500,
                                          color: isDarkMode
                                              ? XColors.darkGray
                                                  .withOpacity(0.7)
                                              : XColors.darkColor1
                                                  .withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: R.w(info, 5),
                                      vertical: R.h(info, 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        KLeafButton(
                                          onPressed: () {
                                            openPage(book.md5!);
                                          },
                                          height: R.w(info, 15),
                                          width: R.w(info, 45),
                                          icon: EvaIcons.globeOutline,
                                          iconColor: isDarkMode
                                              ? XColors.grayText1
                                              : XColors.grayText,
                                          child: KText(
                                            "Go To Site",
                                            font: "MavenPro",
                                            weight: FontWeight.bold,
                                            size: R.f(info, 15),
                                            color: isDarkMode
                                                ? XColors.lightColor1
                                                : XColors.lightColor1,
                                          ),
                                          radius: 0,
                                          color1: isDarkMode
                                              ? XColors.grayText1
                                              : XColors.grayText,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(R.w(info, 5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        KText(
                                          "*this will open webpage externally",
                                          weight: FontWeight.bold,
                                          size: R.f(info, 10),
                                          color: isDarkMode
                                              ? XColors.lightColor1
                                                  .withOpacity(0.4)
                                              : XColors.darkColor1
                                                  .withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
