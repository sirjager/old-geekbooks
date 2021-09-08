import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

class SPermissions {
  static Future<bool> handleStoragePermission() async {
    try {
      var status = await Permission.storage.status;
      if (await Permission.storage.isRestricted) {
        return __request().then((value) {
          if (!value) Kui.toast("You need to give storage permission manually");
          return value;
        });
      } else if (status.isDenied) {
        return __request().then((value) {
          if (!value) Kui.toast("You need to give storage permission manually");
          return value;
        });
      } else if (status.isGranted) {
        return true;
      } else {
        return __request();
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> __request() async =>
      await Permission.storage.request().isGranted;
}
