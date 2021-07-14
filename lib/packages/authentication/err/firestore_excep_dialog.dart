import 'package:geeklibrary/export/export.dart';
import 'package:get/get.dart';

class FirestoreDialog {
  static showDialog(String code, String msg, {String action = "go back"}) {
    final h = (Get.height / 100);
    final w = (Get.width / 100);
    final f = ((Get.width / 100) / 3);
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 5)),
        child: Container(
          // height: h * 40,
          // width: w * 75,
          margin: EdgeInsets.all(w * 5),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(w * 5),
                  child: KText(
                    code,
                    font: "MavenPro",
                    size: f * 16,
                    color: Colors.redAccent[200],
                    weight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(w * 5),
                  child: KText(
                    msg,
                    size: f * 12,
                    font: "Poppins",
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    while (Get.isDialogOpen!) Get.back();
                  },
                  child: Text(action),
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
