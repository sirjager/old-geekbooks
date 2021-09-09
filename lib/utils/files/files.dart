import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:geeklibrary/core/log/log.dart';
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

  static Future<Directory> _getSD() async {
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
    return Directory(newPath);
  }

  static Future<String> getAppPath(
      {String appname = XAppConfig.APP_FOLDER}) async {
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

  static Future<Directory> getDownloadFolderDirectory() async {
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
    return Directory(newPath + "/Download");
  }

  static Future<String> getAndroidDataPath(
      {String appname = XAppConfig.APP_FOLDER}) async {
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

  static Future download2(Dio dio, String url, String savepath) async {
    log.i("Save Path : $savepath");

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
          },
        ),
      );
      File file = File(savepath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  static Future<Directory> handleAppFolderDir(
      {String folderToHandle = XAppConfig.APP_FOLDER}) async {
    final appDirectory = await getAppFolderDir();
    final exist = await appDirectory.exists();
    if (exist) {
      return appDirectory;
    } else {
      return await appDirectory.create(recursive: true);
    }
  }

  static Future<Directory> getAppFolderDir() async {
    final storage = await _getSD();
    return Directory(storage.path + "/" + XAppConfig.APP_FOLDER);
  }
}
