import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/services/hive/hive_service.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/recipe/recipe/detailed_recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe/recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe/recipe_localsource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers/recipe_helpers_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers/recipe_helpers_localsource.dart';
import 'package:pratudo/features/repositories/cache_recipe_repository.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/repositories/recipe_helpers_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/cached_recipe/detailed_cache_recipe_store.dart';
import 'package:pratudo/features/screens/create_recipe/create_recipe_store.dart';
import 'package:pratudo/features/screens/create_recipe/form_section_store.dart';
import 'package:pratudo/features/screens/create_recipe/recipe_form_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/comment_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/detailed_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/rate_recipe_store.dart';
import 'package:pratudo/features/screens/main/views/cached_recipes/cached_recipes_store.dart';
import 'package:pratudo/features/screens/my_recipes/my_recipes_store.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_store.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_store.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

Future<void> setupRecipeLocator() async {
  serviceLocator.registerFactory<RecipeDatasource>(
    () => RecipeDatasource(serviceLocator.get<HttpService>()),
  );

  serviceLocator.registerFactory<RecipeLocalSource>(
    () => RecipeLocalSource(serviceLocator.get<HiveService>()),
  );

  serviceLocator.registerFactory<RecipeHelperDatasource>(
    () => RecipeHelperDatasource(serviceLocator.get<HttpService>()),
  );

  serviceLocator.registerFactory<RecipeHelperLocalSource>(
    () => RecipeHelperLocalSource(serviceLocator.get<HiveService>()),
  );

  serviceLocator.registerFactory<DetailedRecipeDatasource>(
    () => DetailedRecipeDatasource(serviceLocator.get<HttpService>()),
  );

  serviceLocator.registerFactory<RecipeRepository>(
    () => RecipeRepositoryImpl(
      serviceLocator.get<RecipeDatasource>(),
    ),
  );

  serviceLocator.registerFactory<DetailedRecipeRepository>(
    () => DetailedRecipeRepositoryImpl(
      serviceLocator.get<DetailedRecipeDatasource>(),
    ),
  );
  serviceLocator.registerFactory<RecipeHelperRepository>(
    () => RecipeHelperRepositoryImpl(
      serviceLocator.get<RecipeHelperDatasource>(),
      serviceLocator.get<RecipeHelperLocalSource>(),
    ),
  );

  serviceLocator.registerFactory<CacheRecipeRepository>(
    () => CacheRecipeRepositoryImpl(
      serviceLocator.get<RecipeLocalSource>(),
    ),
  );

  serviceLocator.registerFactory<RecipeFormStore>(
    () => RecipeFormStore(),
  );

  serviceLocator.registerFactory<FormSectionStore>(
    () => FormSectionStore(),
  );

  serviceLocator.registerFactory<DetailedRecipeStore>(
    () => DetailedRecipeStore(
      serviceLocator<RecipeRepository>(),
      serviceLocator<CacheRecipeRepository>(),
    ),
  );

  serviceLocator.registerFactory<RecipeCommentStore>(
    () => RecipeCommentStore(
      serviceLocator<DetailedRecipeRepository>(),
      serviceLocator<GamificationObserver>(),
    ),
  );

  serviceLocator.registerFactory<RecipeRateStore>(
    () => RecipeRateStore(
      serviceLocator<DetailedRecipeRepository>(),
      serviceLocator<GamificationObserver>(),
    ),
  );

  serviceLocator.registerFactory<CachedRecipesStore>(
    () => CachedRecipesStore(
      serviceLocator<CacheRecipeRepository>(),
    ),
  );

  serviceLocator.registerFactory<DetailedCacheRecipeStore>(
    () => DetailedCacheRecipeStore(
      serviceLocator<CacheRecipeRepository>(),
    ),
  );

  serviceLocator.registerFactory<StepByStepStore>(
    () => StepByStepStore(),
  );

  serviceLocator.registerFactory<StepStore>(
    () => StepStore(),
  );

  serviceLocator.registerFactory<MyRecipesStore>(
    () => MyRecipesStore(serviceLocator<RecipeRepository>()),
  );

  serviceLocator.registerFactory<CreateRecipeStore>(
    () => CreateRecipeStore(
      serviceLocator<GamificationObserver>(),
      serviceLocator<RecipeRepository>(),
    ),
  );
}
