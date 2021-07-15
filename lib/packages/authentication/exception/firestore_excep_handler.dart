import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geeklibrary/backend/export/backend_export.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:get/get.dart';

class FirestoreExceptionHandler {
  static void handleException(FirebaseException e) {
    __showDialog(title: e.code, msg: e.message.toString());
    log.e(
        "Plugin : ${e.plugin}\nCode : ${e.code}\nDescription : ${e.message.toString()}");
  }

  static __showDialog({
    required String title,
    required String msg,
    String action = "go back",
  }) {
    final String _title =
        title.replaceAll(Str.dash, Str.space).capitalizeFirst!;
    final w = (Get.width / 100);
    final f = ((Get.width / 100) / 3);
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 5)),
        child: Container(
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
                    _title,
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
      useRootNavigator: false,
    );
  }
}
