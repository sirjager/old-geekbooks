import 'package:geeklibrary/export/export.dart';
import 'package:get/get.dart';

class FirestoreDialog {
  static showDialog(String code, String msg) {
    final h = (Get.height / 100);
    final w = (Get.width / 100);
    Get.dialog(
      Dialog(
        child: Container(
          height: h * 40,
          width: w * 75,
          padding: EdgeInsets.all(w * 5),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(w * 5),
                  child: Text("Code : $code"),
                ),
                Container(
                  padding: EdgeInsets.all(w * 5),
                  child: Text("Code : $msg"),
                ),
                OutlinedButton(
                  onPressed: () {
                    while (Get.isDialogOpen!) Get.back();
                  },
                  child: Text("okay"),
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
