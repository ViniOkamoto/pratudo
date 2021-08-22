import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/authentication_datasource.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';
import 'package:pratudo/features/screens/register/register_store.dart';

Future<void> setupAuthenticationLocator() async {
  serviceLocator.registerFactory<AuthenticationDatasource>(
    () => AuthenticationDatasource(serviceLocator.get<HttpService>()),
  );
  serviceLocator.registerFactory<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(serviceLocator.get<AuthenticationDatasource>()),
  );

  serviceLocator.registerFactory<RegisterStore>(
    () => RegisterStore(serviceLocator.get<AuthenticationRepository>()),
  );
}
