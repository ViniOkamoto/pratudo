import 'package:hive/hive.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';

part 'recipe_helper_model.g.dart';

@HiveType(typeId: CategoryHiveHelper.type)
class RecipeHelperModel {
  @HiveField(CategoryHiveHelper.keyField)
  String key;
  @HiveField(CategoryHiveHelper.valueField)
  String value;
  @HiveField(CategoryHiveHelper.imageField)
  String? image64;

  RecipeHelperModel({required this.key, required this.value, this.image64});

  static RecipeHelperModel fromJson(Map<String, dynamic> json) =>
      RecipeHelperModel(
        key: json['key'],
        value: json['value'],
        image64: json['image'],
      );

  static List<RecipeHelperModel> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
