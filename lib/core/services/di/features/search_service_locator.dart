import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';
import 'package:pratudo/features/screens/login/login_store.dart';

Future<void> setupSearchLocator() async {
  serviceLocator.registerFactory<LoginStore>(
    () => LoginStore(serviceLocator.get<AuthenticationRepository>()),
  );
}
