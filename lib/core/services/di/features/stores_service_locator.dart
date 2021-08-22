import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';
import 'package:pratudo/features/stores/user_information_store.dart';

Future<void> setupStoresLocator() async {
  serviceLocator.registerLazySingleton<UserInformationStore>(
    () => UserInformationStore(serviceLocator.get<AuthenticationRepository>()),
  );
}
