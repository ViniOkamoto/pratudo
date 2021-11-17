import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/recipe/recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers_datasource.dart';
import 'package:pratudo/features/repositories/recipe_helpers_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/screens/create_recipe/recipe_form_store.dart';

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

  serviceLocator.registerFactory<RecipeFormStore>(
    () => RecipeFormStore(),
  );

  serviceLocator.registerFactory<FormSectionStore>(
    () => FormSectionStore(),
  );
}
