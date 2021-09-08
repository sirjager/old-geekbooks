import 'package:geeklibrary/backend/calls/api_calls.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/core/services/permissions.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/lenk/lenk.dart';
import 'package:geeklibrary/pages/results/components/header.dart';
import 'package:geeklibrary/pages/zoom/zoom.dart';
import 'package:geeklibrary/utils/files/files.dart';
import 'package:open_file/open_file.dart';
import 'package:geeklibrary/widgets/kImage/kimage.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
                                if (buttonProvider != null)
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 60.w, vertical: 30.w),
                                    child: Consumer(
                                        builder: (context, watch, child) {
                                      var got = watch(buttonProvider!);
                                      return got.when(
                                        data: (list) => buildDownloadButton(
                                            isDarkMode, list, book),
                                        loading: () => Container(),
                                        error: (e, s) => Text(e.toString()),
                                      );
                                    }),
                                  ),
                                SizedBox(height: 100.h),
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

  Widget buildDownloadButton(bool isDarkMode, List<Lenk> lenks, Book book) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: lenks
          .map((e) => OutlinedButton(
                onPressed: () => openPage(e.lenk, book),
                child: KText(
                  e.title.toUpperCase(),
                  font: "MavenPro",
                  weight: FontWeight.bold,
                  size: 45.sp,
                  color: isDarkMode ? XColors.lightColor1 : XColors.darkColor2,
                ),
              ))
          .toList(),
    );
  }

  void openPage(String url, Book book) async {
    bool _canLaunch = await launch.canLaunch(url);
    if (_canLaunch) {
      await downloadFile(url, book);
    }
  }

  Future<bool> downloadFile(String url, Book book) async {
    try {
      final hasPermission = await SPermissions.handleStoragePermission();
      if (hasPermission) {
        Get.snackbar(
          "Download Started",
          book.title ?? book.author ?? "",
          snackPosition: SnackPosition.BOTTOM,
        );
        final dir = await XFiles.getAppPath();
        final fileName = (book.title ?? book.author ?? "Geeklibrary") +
            "_${DateTime.now()}" +
            ".${book.exten!}";
        final String filepath = dir + "/" + fileName;
        await FlutterDownloader.enqueue(
          url: url,
          savedDir: dir,
          showNotification: true,
          openFileFromNotification: true,
          fileName: fileName,
        );

        Get.snackbar(
          "Download Finished",
          book.title ?? book.author ?? "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: XColors.grayColor,
          colorText: XColors.darkColor1,
          onTap: (tap) {},
        );
      }
    } catch (e) {
      log.e(e.toString());
    }

    return true;
  }

  final downloadProgressProvider =
      ChangeNotifierProvider((_) => DownloadProgressProvider());
}

class DownloadProgressProvider extends ChangeNotifier {
  int _received = 0;
  int _total = 0;
  int get received => _received;
  int get total => _total;
  double _proggress = 0.0;
  double get progress => _proggress;

  void update(int received, int total) {
    _received = received;
    _total = total;
    _proggress = _received / _total;
    print(_proggress);
    notifyListeners();
  }
}
