import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/gamefication/gamefication_datasource.dart';
import 'package:pratudo/features/repositories/gamefication_repository.dart';
import 'package:pratudo/features/stores/shared/user_progress_store.dart';

Future<void> setupGamificationLocator() async {
  serviceLocator.registerFactory<GamificationDatasource>(
    () => GamificationDatasource(
      serviceLocator.get<HttpService>(),
    ),
  );

  serviceLocator.registerFactory<GamificationRepository>(
    () => GamificationRepositoryImpl(
      serviceLocator.get<GamificationDatasource>(),
    ),
  );

  serviceLocator.registerLazySingleton<UserProgressStore>(
    () => UserProgressStore(
      serviceLocator.get<GamificationRepository>(),
    ),
  );
}
