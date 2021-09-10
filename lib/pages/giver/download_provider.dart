import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/core/services/permissions.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/utils/files/files.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_settings/system_settings.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

import 'download_result.dart';

class FileDownloadProvider {
  static Future<bool> downloadFile(
      String url, Book book, bool downloadWithBrowser) async {
    var dio = dioo.Dio();
    try {
      await SPermissions.handleStoragePermission();
      final _storagePermission = await Permission.storage.status;
      final _android = await DeviceInfoPlugin().androidInfo;
      late final bool _externalPermission;
      if (int.parse(_android.version.release) > 10) {
        _externalPermission = await Permission.manageExternalStorage.isGranted;
      } else {
        _externalPermission = true;
      }
      final hasPermission = _storagePermission.isGranted && _externalPermission;
      if (hasPermission) {
        if (url.length > 8) {
          final appfolder = await XFiles.handleAppFolderDir();
          String _filename = "";
          if (book.author != null) {
            _filename = book.author! + " - ";
          } else {}
          if (book.title != null) {
            _filename = _filename + book.title!;
          } else {}
          if (book.year != null) {
            _filename = _filename + "(${book.year!})";
          } else {}
          if (book.edition != null) {
            _filename = _filename + "\[${book.edition!}-EDITION\]";
          } else {}
          final fileName = _filename + "." + (book.exten ?? "");
          final String filepath = appfolder.path + "/" + fileName;
          final checkForFileBeforeStarting =
              await ___checkForFile(filepath, fileName, appfolder);
          if (checkForFileBeforeStarting.isSucess) {
            __finishedSnackbar(filepath, fileName);
          } else {
            if (downloadWithBrowser) {
              await launch.launch(url);
            } else {
              Get.snackbar(
                "Download Started",
                book.title ?? book.author ?? book.id,
                snackPosition: SnackPosition.BOTTOM,
              );
              await XFiles.download2(dio, url, filepath);
              final checkForFileAfterStarting =
                  await ___checkForFile(filepath, fileName, appfolder);

              if (checkForFileAfterStarting.isSucess) {
                __finishedSnackbar(
                    checkForFileAfterStarting.filePath!, fileName);
              } else {
                Get.snackbar(
                  "Something went wrong",
                  "Try another link\nIf still not working try\nEnabling Browser Mode",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 5),
                  backgroundColor: XColors.grayColor.withOpacity(0.3),
                  colorText: Colors.black,
                );
              }
            }
          }
        }
      } else {
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
    } catch (e) {
      print(e);
      Kui.toast(e.toString());
    }

    return true;
  }

  static Future<FileResult> ___checkForFile(
      String filepath, String filename, Directory appfolder) async {
    //! First Check Appfolder if file exists
    final fileExist = await File(filepath).exists();
    if (fileExist) {
      return FileResult(
        dirPath: appfolder,
        filePath: filepath,
        fileName: filename,
        isSucess: fileExist,
      );
    } else {
      //! Check if file exists in Downloads Folder
      final downloadFolder = await XFiles.getDownloadFolderDirectory();
      final fileExistInDownloads =
          await File(downloadFolder.path + "/" + filename).exists();
      return FileResult(
        dirPath: downloadFolder,
        filePath: downloadFolder.path + "/" + filename,
        fileName: filename,
        isSucess: fileExistInDownloads,
      );
    }
  }

  static void __finishedSnackbar(String filepath, String fileName) =>
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
          ),
        ),
      );
}
