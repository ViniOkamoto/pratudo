import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/recipe/recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers_datasource.dart';
import 'package:pratudo/features/repositories/recipe_helpers_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';

Future<void> setupRecipeLocator() async {
  serviceLocator.registerFactory<RecipeDatasource>(
    () => RecipeDatasource(serviceLocator.get<HttpService>()),
  );

  serviceLocator.registerFactory<RecipeHelperDatasource>(
    () => RecipeHelperDatasource(serviceLocator.get<HttpService>()),
  );

  serviceLocator.registerFactory<RecipeRepository>(
    () => RecipeRepositoryImpl(
      serviceLocator.get<RecipeDatasource>(),
    ),
  );
  serviceLocator.registerFactory<RecipeHelperRepository>(
    () => RecipeHelperRepositoryImpl(
      serviceLocator.get<RecipeHelperDatasource>(),
    ),
  );

  serviceLocator.registerFactory<ExploreStore>(
    () => ExploreStore(serviceLocator.get<RecipeRepository>()),
  );
}
