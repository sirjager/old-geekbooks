import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:geeklibrary/core/log/log.dart';
import 'package:geeklibrary/core/services/permissions.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:path_provider/path_provider.dart';

import 'const.dart';

class XFiles {
  static var dio = Dio();
  static File getFile(String dir, String filename, {String exten = "jpg"}) =>
      File(dir + "/" + filename + ".$exten");

  static Future<File> writeFile(File file, Uint8List bytes,
      {FileMode mode = FileMode.writeOnly}) async {
    return file.writeAsBytes(bytes, mode: mode);
  }

  static Future<List<String>> getList(String path) async {
    final _dir = Directory(path);
    final List<FileSystemEntity> items =
        await _dir.list(recursive: false).toList();
    List<String> paths = [];
    for (FileSystemEntity item in items) {
      paths.add(item.path);
    }
    return paths;
  }

  static Future<String> getSD() async {
    final dir = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = dir!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    return newPath;
  }

  static Future<String> getAppPath({String appname = "GeekLibrary"}) async {
    final dir = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = dir!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    return newPath + "/$appname";
  }

  static Future<String> getAndroidDataPath(
      {String appname = "GeekLibrary"}) async {
    final dir = await getExternalStorageDirectory();
    final String appid = XAppConfig.APP_ID;
    String newPath = "";
    List<String> paths = dir!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    return newPath + "/Android/data/$appid";
  }

  static Future<Directory> createFolder(String path) async =>
      await Directory(path).create(recursive: true);

  static Future<bool> downloadFile(String url, Book book) async {
    try {
      final hasPermission = await SPermissions.handleStoragePermission();
      if (hasPermission) {
        Get.snackbar(
          "Download Started",
          book.title ?? book.author ?? "",
          snackPosition: SnackPosition.BOTTOM,
        );
        final dir = await getAppPath();
        final fileName = (book.title ?? book.author ?? "Geeklibrary") +
            "_${DateTime.now()}" +
            ".${book.exten!}";
        await dio.download(
          url,
          dir + "/" + fileName,
          onReceiveProgress: (int received, int total) {},
        );
      }
    } catch (e) {
      log.e(e.toString());
    }

    return true;
  }

  static Future download2(Dio dio, String url, String savePath) async {
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: (r, t) {},
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              if (status != null) return status < 500;
              return false;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
}
