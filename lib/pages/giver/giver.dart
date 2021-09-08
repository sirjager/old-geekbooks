import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/zoom/zoom.dart';
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
    return Scaffold(
      body: !delayed
          ? Center(
              child: Lottie.asset(MyAssets.books, height: 350.w, onLoaded: (_) {
                Future.delayed(Duration(seconds: 2)).then((value) {
                  setState(() {
                    delayed = true;
                  });
                });
              }),
            )
          : Container(
              margin: EdgeInsets.only(top: 90.h),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: ResultHeader(
                          title: "Go Back", disableToggleView: true)),
                  Container(
                    child: Consumer(
                      builder: (context, watch, child) {
                        var isDarkMode = watch(themeProvider).isDarkMode;
                        return Expanded(
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(50.w),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? XColors.grayColor
                                          : XColors.darkColor,
                                      borderRadius: BorderRadius.circular(40.w),
                                      border: Border.all(
                                        color: isDarkMode
                                            ? XColors.grayColor
                                            : XColors.darkColor,
                                        width: 15.w,
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
                                            height: 700.w,
                                            width: 450.w,
                                            imageURL: book.coverURL,
                                            borderRadius:
                                                BorderRadius.circular(40.w),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1000.w,
                                  child: KText(
                                    book.title!,
                                    font: "MavenPro",
                                    size: 60.sp,
                                    weight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    color: isDarkMode
                                        ? XColors.darkGray.withOpacity(0.7)
                                        : XColors.darkColor1.withOpacity(0.7),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 60.w, vertical: 40.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        'File Size : ',
                                        font: "MavenPro",
                                        size: 60.sp,
                                        weight: FontWeight.w500,
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.7)
                                            : XColors.darkColor1
                                                .withOpacity(0.7),
                                      ),
                                      KText(
                                        XMath.convertBytesToMB(book.fileSize) +
                                            ' MB',
                                        font: "MavenPro",
                                        size: 60.sp,
                                        weight: FontWeight.w500,
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.7)
                                            : XColors.darkColor1
                                                .withOpacity(0.7),
                                      ),
                                      SizedBox(width: 40.w),
                                      KText(
                                        'Extension : ',
                                        font: "MavenPro",
                                        size: 60.sp,
                                        weight: FontWeight.w500,
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.7)
                                            : XColors.darkColor1
                                                .withOpacity(0.7),
                                      ),
                                      KText(
                                        book.exten ?? "unknown",
                                        font: "MavenPro",
                                        size: 65.sp,
                                        weight: FontWeight.w500,
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.7)
                                            : XColors.darkColor1
                                                .withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 60.w, vertical: 30.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      KLeafButton(
                                        onPressed: () {
                                          openPage(book.md5!);
                                        },
                                        height: 170.w,
                                        width: 450.w,
                                        icon: EvaIcons.globeOutline,
                                        iconColor: isDarkMode
                                            ? XColors.grayText1
                                            : XColors.grayText,
                                        child: KText(
                                          "Go To Site",
                                          font: "MavenPro",
                                          weight: FontWeight.bold,
                                          size: 45.sp,
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
                                  margin: EdgeInsets.all(50.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        "*this will open webpage externally",
                                        weight: FontWeight.bold,
                                        size: 40.sp,
                                        color: isDarkMode
                                            ? XColors.lightColor1
                                                .withOpacity(0.3)
                                            : XColors.darkColor1
                                                .withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
