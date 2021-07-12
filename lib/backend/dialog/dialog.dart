import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:geekbooks/export/export.dart';

class UiDialog {
  static void showExceptionDialog(
      {String title = "Error",
      String desc = "Something went wrong",
      SizingInformation? info}) {
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: info != null ? R.h(info, 35) : 400,
          width: info != null ? R.w(info, 40) : 300,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MyAssets.cross,
                      height: info != null ? R.h(info, 15) : 50),
                  Text(
                    title,
                    style: Get.textTheme.headline4,
                  ),
                  Text(
                    desc,
                    style: Get.textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {
                      if (Get.isDialogOpen == true) Get.back();
                    },
                    child: Text("Okay"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showNoResultsDialog(SizingInformation info,
      {String title = "Search Complete", String desc = "No Results Found"}) {
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: R.h(info, 35),
          width: R.w(info, 40),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(MyAssets.notfound1, height: R.h(info, 15)),
                KText(title, size: R.f(info, 20), weight: FontWeight.bold),
                SizedBox(height: R.h(info, 2)),
                KText(desc, size: R.f(info, 10), weight: FontWeight.bold),
                SizedBox(height: R.h(info, 2)),
                KClickable(
                    height: R.h(info, 5),
                    width: R.w(info, 18),
                    topDeco: G.blueGradBannerDeco,
                    bottomDeco: G.blackGradButtonDeco,
                    onPressed: () {
                      if (Get.isDialogOpen == true) Get.back();
                    },
                    child: KText("Okay",
                        size: R.f(info, 11), weight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
