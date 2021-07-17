import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/zoom/zoom.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
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
                                        KClickable(
                                          height: R.h(info, 8),
                                          width: R.w(info, 38),
                                          onPressed: () {
                                            openPage(book.md5!);
                                          },
                                          child: KText(
                                            "visit download page",
                                            font: "Poppins",
                                            size: R.f(info, 10),
                                            color: isDarkMode
                                                ? XColors.grayText
                                                : XColors.darkColor,
                                            weight: FontWeight.w600,
                                          ),
                                          topDeco: isDarkMode
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  gradient: G
                                                      .blackGradButtonDeco
                                                      .gradient,
                                                )
                                              : BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    XColors.darkGray,
                                                    XColors.darkGray,
                                                  ]),
                                                ),
                                          bottomDeco: isDarkMode
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Colors.black,
                                                    randomLightColor(),
                                                    randomLightColor(),
                                                  ]),
                                                )
                                              : G.blackGradButtonDeco,
                                        )
                                      ],
                                    ),
                                  ),
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

  _viewImage(SizingInformation info, imageURL, {double radius = 24.0}) {
    return Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        content: Hero(
          tag: "giberThis",
          child: KImage(
            fit: BoxFit.fill,
            imageURL: imageURL,
            width: R.w(info, 50),
            height: R.w(info, 90),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      barrierColor: Colors.black87,
    );
  }
}
