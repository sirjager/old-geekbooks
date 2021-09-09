import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_settings/system_settings.dart';

class SPermissions {
  static Future<bool> handleStoragePermission() async {
    try {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final hasAccess = await __request();
        if (!hasAccess)
          showDialog(hasAccess);
        else {}
        return hasAccess;
      } else
        return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> __request() async {
    final storage = await Permission.storage.request().isGranted;
    final externalStorage =
        await Permission.manageExternalStorage.request().isGranted;
    return storage && externalStorage;
  }

  static showDialog(bool hasAccess) {
    Get.snackbar(
      "NO STORAGE PERMISSION",
      "Geeklibrary dosenot have storage permission\nOpen App Settings to give permission manually",
      duration: Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.3),
      colorText: Colors.black,
      mainButton: TextButton(
        onPressed: SystemSettings.app,
        child: KText(
          "open settings",
          size: 40.sp,
          color: Colors.black,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
