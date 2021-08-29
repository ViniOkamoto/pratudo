import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/screens/main/main_store.dart';

Future<void> setupMainServiceLocator() async {
  serviceLocator.registerFactory<MainStore>(() => MainStore());
}
