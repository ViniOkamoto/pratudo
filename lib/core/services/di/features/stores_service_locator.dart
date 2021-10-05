import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/repositories/authentication_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/stores/shared/user_information_store.dart';

Future<void> setupStoresLocator() async {
  serviceLocator.registerLazySingleton<UserInformationStore>(
    () => UserInformationStore(serviceLocator.get<AuthenticationRepository>()),
  );

  serviceLocator.registerFactory<SearchStore>(
    () => SearchStore(serviceLocator.get<RecipeRepository>()),
  );
}
