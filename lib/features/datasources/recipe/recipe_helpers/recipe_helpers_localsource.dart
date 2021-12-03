import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/core/services/hive/hive_service.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class RecipeHelperLocalSource {
  final HiveService _service;

  RecipeHelperLocalSource(this._service);

  List<UnitModel> getUnitsOfMeasurement() {
    try {
      final response = _service.boxes.getUnitsOfMeasure();

      return response.values.toList().cast<UnitModel>();
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> saveUnitsOfMeasure(List<UnitModel> units) async {
    try {
      final box = await _service.getBox(typeString: UnitHiveHelper.boxName);

      units.forEach((element) => box.add(element));
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  List<RecipeHelperModel> getCategories() {
    try {
      final response = _service.boxes.getCategories();

      return response.values.toList().cast<RecipeHelperModel>();
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<void> saveCategories(List<RecipeHelperModel> categories) async {
    try {
      final box = await _service.getBox(typeString: CategoryHiveHelper.boxName);

      categories.forEach((element) => box.add(element));
    } on LocalCacheException catch (e) {
      throw LocalFailure(errorText: e.errorText);
    } on Exception catch (e) {
      throw e;
    }
  }
}
