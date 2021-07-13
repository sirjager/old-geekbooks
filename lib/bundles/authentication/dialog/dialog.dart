import 'package:geekbooks/export/export.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AuthDialog {
  static showDialog(BuildContext ctx,
      {String? title, String? desc, String? lottie}) {
    var size = MediaQuery.of(ctx).size;
    var height = (size.height) / 100;
    var width = (size.width) / 100;
    Get.dialog(
      Dialog(
        child: Container(
          height: height * 35,
          width: width * 85,
          padding: EdgeInsets.all(width * 5),
          child: Column(
            children: [
              Lottie.asset(lottie ?? MyAssets.checkmail, height: height * 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 10),
                child: KText("Verify your email", size: (width / 3) * 10),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
