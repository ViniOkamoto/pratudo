import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/hive/boxes.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class HiveService {
  final HiveInterface hive;
  final Boxes boxes;
  HiveService({required this.hive, required this.boxes});

  Future<void> init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    hive
      ..init(directory.path)
      ..registerAdapter(RecipeHelperModelAdapter())
      ..registerAdapter(CacheRecipeModelAdapter())
      ..registerAdapter(UnitModelAdapter());

    await hive.openBox<UnitModel>(UnitHiveHelper.boxName);
    await hive.openBox<CacheRecipeModel>(RecipeHiveHelper.boxName);
    await hive.openBox<RecipeHelperModel>(CategoryHiveHelper.boxName);
  }

  Future<Box> getBox({required String typeString}) async {
    try {
      Box box;
      switch (typeString) {
        case UnitHiveHelper.boxName:
          box = boxes.getUnitsOfMeasure();
          break;
        case RecipeHiveHelper.boxName:
          box = boxes.getCacheRecipes();
          break;
        case CategoryHiveHelper.boxName:
          box = boxes.getCategories();
          break;
        default:
          throw LocalCacheException(errorText: "Error interno");
      }
      return box;
    } catch (e) {
      throw LocalCacheException(errorText: "Erro ao buscar dados");
    }
  }
}
