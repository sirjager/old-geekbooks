import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _secXstorage = FlutterSecureStorage();

  Future<void> saveData(String key, value) async =>
      await _secXstorage.write(key: key, value: value);

  Future<String?> readData(String key) async {
    var _readData = await _secXstorage.read(key: key);
    return _readData;
  }

  Future<void> deleteData(String key) async =>
      await _secXstorage.delete(key: key);
}
