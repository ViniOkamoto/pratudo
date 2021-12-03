import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/core/services/hive/hive_service.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';

class RecipeLocalSource {
  final HiveService _service;

  RecipeLocalSource(this._service);

  List<CacheRecipeModel> getCachedRecipes() {
    try {
      final response = _service.boxes.getCacheRecipes();

      return response.values.toList().cast<CacheRecipeModel>();
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> saveRecipe(CacheRecipeModel recipeModel) async {
    try {
      final box = await _service.getBox(typeString: RecipeHiveHelper.boxName);

      box.add(recipeModel);
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> deleteRecipe(CacheRecipeModel recipeModel) async {
    try {
      await recipeModel.delete();
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  void deleteRecipeById(String id) {
    try {
      final box = _service.boxes.getCacheRecipes();

      final List<CacheRecipeModel> cache =
          box.values.toList().cast<CacheRecipeModel>();

      cache.firstWhere((element) => element.id == id).delete();
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  bool checkIfIsCached(String id) {
    try {
      final box = _service.boxes.getCacheRecipes();

      final List<CacheRecipeModel> cache =
          box.values.toList().cast<CacheRecipeModel>();

      return cache.any((element) => element.id == id);
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }
}
