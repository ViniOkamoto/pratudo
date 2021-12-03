import 'package:hive/hive.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class Boxes {
  Box<UnitModel> getUnitsOfMeasure() =>
      Hive.box<UnitModel>(UnitHiveHelper.boxName);
  Box<CacheRecipeModel> getCacheRecipes() =>
      Hive.box<CacheRecipeModel>(RecipeHiveHelper.boxName);
  Box<RecipeHelperModel> getCategories() =>
      Hive.box<RecipeHelperModel>(CategoryHiveHelper.boxName);
}
