import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/storage_service.dart';

class AuthenticationLocalDatasource {
  final StorageService _storageService;

  AuthenticationLocalDatasource(this._storageService);

  Future<void> saveAuthentication(String token) async {
    try {
      await _storageService.write(key: "accessToken", value: token);
      return;
    } catch (e) {
      throw LocalCacheException(errorText: e.toString());
    }
  }

  Future<String?> getToken() async {
    try {
      return await _storageService.read(key: "accessToken");
    } catch (e) {
      throw LocalCacheException(errorText: e.toString());
    }
  }

  Future<void> deleteToken() async {
    try {
      return await _storageService.delete(key: "accessToken");
    } catch (e) {
      throw LocalCacheException(errorText: e.toString());
    }
  }
}
