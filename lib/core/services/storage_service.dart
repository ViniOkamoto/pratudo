import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  FlutterSecureStorage _secureStorage = new FlutterSecureStorage();
  StorageService({
    required FlutterSecureStorage secureStorage,
  }) : this._secureStorage = secureStorage;

  Future<dynamic> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  Future write({required String key, required dynamic value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<bool?> getBool({required String key}) async {
    var booleanString = await _secureStorage.read(key: key);
    if (booleanString == 'true') return true;
    if (booleanString == 'false') return false;
    return null;
  }

  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }
}
