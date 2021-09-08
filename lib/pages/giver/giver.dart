import 'dart:io';

import 'package:dio/dio.dart' as dioo;
import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/core/services/permissions.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/lenk/lenk.dart';
import 'package:geeklibrary/pages/giver/provider.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/zoom/zoom.dart';
import 'package:geeklibrary/utils/files/files.dart';
import 'package:open_file/open_file.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
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

  late final FutureProvider? buttonProvider =
      FutureProvider<List<Lenk>>((_) async {
    if (widget.book.md5 != null) {
      return await ApiCalls().getDownLenx(
          widget.book.md5!, widget.book.id, widget.book.title ?? "");
    } else
      return [];
  });

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
                        var extenal = watch(externalIndicator);
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
                                    googleFont: GoogleFonts.mavenPro(),
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
                                        googleFont: GoogleFonts.mavenPro(),
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
                                        googleFont: GoogleFonts.mavenPro(),
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
                                        googleFont: GoogleFonts.mavenPro(),
                                        size: 60.sp,
                                        weight: FontWeight.w500,
                                        color: isDarkMode
                                            ? XColors.darkGray.withOpacity(0.7)
                                            : XColors.darkColor1
                                                .withOpacity(0.7),
                                      ),
                                      KText(
                                        book.exten ?? "unknown",
                                        googleFont: GoogleFonts.mavenPro(),
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
                                SizedBox(height: 100.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    KText(
                                      "Download with browser ?",
                                      googleFont: GoogleFonts.mavenPro(),
                                      size: 55.sp,
                                      weight: FontWeight.bold,
                                      color: isDarkMode
                                          ? XColors.darkGray.withOpacity(0.7)
                                          : XColors.darkColor1.withOpacity(0.7),
                                    ),
                                    CupertinoSwitch(
                                      value: extenal.external,
                                      onChanged: (val) =>
                                          extenal.changeMode(val),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                            helpWidget(isDarkMode, extenal));
                                      },
                                      child: Icon(
                                        Ionicons.help_circle_outline,
                                        size: 120.sp,
                                      ),
                                    )
                                  ],
                                ),
                                if (buttonProvider != null)
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 60.w, vertical: 30.w),
                                    child: Consumer(
                                        builder: (context, watch, child) {
                                      var got = watch(buttonProvider!);
                                      return got.when(
                                        data: (list) => buildDownloadButton(
                                            isDarkMode,
                                            list,
                                            book,
                                            extenal.external),
                                        loading: () => Lottie.asset(
                                            MyAssets.bookLoading,
                                            height: 350.h),
                                        error: (e, s) => Text(e.toString()),
                                      );
                                    }),
                                  ),
                                SizedBox(height: 300.h),
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

  Future<List<Lenk>> getDownloadLinks(Book book) async {
    if (book.md5 != null) {
      return await ApiCalls().getDownLenx(book.md5!, book.id, book.title ?? "");
    } else
      return [];
  }

  Widget buildDownloadButton(
      bool isDarkMode, List<Lenk> lenks, Book book, bool extenal) {
    return Wrap(
      children: lenks
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.w),
                child: KClickable(
                  height: 200.w,
                  width: 350.w,
                  onPressed: () {
                    openPage(e.lenk, book, extenal);
                  },
                  child: KText(
                    e.title.toUpperCase(),
                    googleFont: GoogleFonts.mavenPro(),
                    weight: FontWeight.bold,
                    size: 45.sp,
                    color: isDarkMode ? XColors.darkColor1 : XColors.darkColor2,
                  ),
                  topDeco: G.green2GradBannerDeco,
                  bottomDeco: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: XColors.darkColor2,
                  ),
                ),
              ))
          .toList(),
    );
  }

  void openPage(String url, Book book, bool external) async {
    bool _canLaunch = await launch.canLaunch(url);
    if (_canLaunch) {
      if (external)
        await launch.launch(url);
      else
        await downloadFile(url, book);
    }
  }

  Future<bool> downloadFile(String url, Book book,
      {bool downloadExternaly = false}) async {
    var dio = dioo.Dio();
    try {
      final hasPermission = await SPermissions.handleStoragePermission();
      if (hasPermission) {
        if (url.length > 8) {
          final dir = await XFiles.getAppPath();
          final fileName =
              (book.title ?? book.author ?? DateTime.now().toString()) +
                  ".${book.exten!}";
          final String filepath = dir + "/" + fileName;
          Get.snackbar(
            "Download Started",
            book.title ?? book.author ?? "",
            snackPosition: SnackPosition.BOTTOM,
          );

          await XFiles.download2(dio, url, filepath);
          final exist = await checkForFile(dir, fileName);
          if (exist) {
            Get.snackbar(
              "Download finished",
              fileName,
              duration: Duration(seconds: 5),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: XColors.grayColor.withOpacity(0.3),
              colorText: Colors.black,
              mainButton: TextButton(
                  onPressed: () => OpenFile.open(filepath),
                  child: KText(
                    "Open",
                    color: Colors.black,
                    weight: FontWeight.bold,
                  )),
            );
          } else {
            Get.snackbar(
              "Something went wrong",
              "Try another link\nIf still not working try\nEnabling Browser Mode",
              isDismissible: false,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 5),
              backgroundColor: XColors.grayColor.withOpacity(0.3),
              colorText: Colors.black,
              mainButton: TextButton(
                  onPressed: () =>
                      downloadFile(url, book, downloadExternaly: true),
                  child: KText(
                    "Retry",
                    color: Colors.black,
                    weight: FontWeight.bold,
                  )),
            );
          }
        }
      }
    } catch (e) {
      log.e(e.toString());
    }

    return true;
  }

  Future<bool> checkForFile(String dir, String fileName) async {
    final _dir = Directory(dir);
    final List<FileSystemEntity> items =
        await _dir.list(recursive: false).toList();
    bool exist = false;
    for (FileSystemEntity item in items) {
      final file = item.path.split("/").last;
      if (file.contains(fileName)) {
        exist = true;
      } else {
        exist = false;
      }
    }
    return exist;
  }

  Widget helpWidget(bool isDarkMode, DownloadExternallyProvider pro) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? XColors.darkColor : XColors.lightColor1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    "Frequently Asked Questions",
                    size: 75.sp,
                    color: XColors.grayColor,
                    weight: FontWeight.bold,
                    googleFont: GoogleFonts.mavenPro(),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              KText(
                "How many providers are there ?",
                color: Colors.red,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              KText(
                "There are 4 different download providers.",
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: providerList
                    .map(
                      (e) => Container(
                        decoration: G.green2GradBannerDeco,
                        height: 100.w,
                        width: 200.w,
                        alignment: Alignment.center,
                        child: KText(
                          e,
                          size: 30.sp,
                          weight: FontWeight.bold,
                          color: isDarkMode
                              ? XColors.darkColor1
                              : XColors.lightColor1,
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 40.h),
              KText(
                "What should i do if link dosen't work ?",
                color: Colors.red,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              KText(
                "If one dosen't work or show \"Something went wrong\",then try downloading with different download provider.",
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              SizedBox(height: 40.h),
              KText(
                "Some links are old and might not work or take more time",
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              SizedBox(height: 40.h),
              KText(
                "What can i do if in-app downloading is not working ?",
                color: Colors.red,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              KText(
                "If In-App Download is still not working then try switching to Browser Mode.",
                color: XColors.grayColor,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    "Enable Broweser Mode",
                    googleFont: GoogleFonts.mavenPro(),
                    size: 55.sp,
                    weight: FontWeight.bold,
                    color: isDarkMode
                        ? XColors.darkGray.withOpacity(0.7)
                        : XColors.darkColor1.withOpacity(0.7),
                  ),
                  CupertinoSwitch(
                    value: pro.external,
                    onChanged: (val) {
                      pro.changeMode(val);
                      while (Get.isBottomSheetOpen == true) {
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              KText(
                "BROWSER MODE will open same download link in your browser.",
                color: Colors.blueAccent,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              SizedBox(height: 40.h),
              KText(
                "After File is Downloaded You can directly open from Popup Snackbar",
                color: Colors.yellowAccent,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
              SizedBox(height: 40.h),
              KText(
                "Snackbar Will automatically close after 5 seconds",
                color: Colors.yellowAccent,
                weight: FontWeight.bold,
                googleFont: GoogleFonts.mavenPro(),
              ),
            ],
          ),
        ),
      );

  List<String> providerList = ["GET", "CLOUDFLARE", "IPFS", "INFURA"];
}
