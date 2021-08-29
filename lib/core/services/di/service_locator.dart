import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pratudo/core/services/di/features/authentication_service_locator.dart';
import 'package:pratudo/core/services/di/features/main_service_locator.dart';
import 'package:pratudo/core/services/di/features/stores_service_locator.dart';
import 'package:pratudo/core/services/http/bearer_interceptor.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/core/services/storage_service.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  _setupServices();

  setupAuthenticationLocator();
  setupMainServiceLocator();
  setupStoresLocator();
}

Future<void> _setupServices() async {
  serviceLocator.registerSingleton(Dio());
  serviceLocator.registerFactory(() => FlutterSecureStorage());
  serviceLocator.registerSingleton(StorageService(secureStorage: serviceLocator<FlutterSecureStorage>()));
  serviceLocator.registerFactory(
    () => BearerInterceptor(
      dio: serviceLocator<Dio>(),
      storageService: serviceLocator<StorageService>(),
    ),
  );
  serviceLocator.registerSingleton(
    HttpService(
      dio: serviceLocator<Dio>(),
      interceptors: [
        serviceLocator<BearerInterceptor>(),
      ],
    ),
  );
}
