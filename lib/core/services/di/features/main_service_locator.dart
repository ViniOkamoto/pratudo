import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/main/main_store.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';

Future<void> setupMainServiceLocator() async {
  serviceLocator.registerFactory<MainStore>(() => MainStore());

  serviceLocator.registerFactory<ExploreStore>(
    () => ExploreStore(serviceLocator.get<RecipeRepository>()),
  );
}
