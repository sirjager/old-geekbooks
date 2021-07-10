import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:geekbooks/export/export.dart';

class UiDialog {
  static void showExceptionDialog(
      {String title = "Error", String desc = "Something went wrong"}) {
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: 100,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MyAssets.cross, height: 200),
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
    );
  }
}
