import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/method_of_preparation_model.dart';

class RecipeCreationModel {
  RecipeCreationModel({
    required this.name,
    required this.images,
    required this.difficulty,
    required this.serves,
    required this.chefTips,
    required this.ingredients,
    required this.methodOfPreparation,
    required this.categories,
  });
  late final String name;
  late final List<String> images;
  late final String difficulty;
  late final int serves;
  late final String chefTips;
  late final List<IngredientModel> ingredients;
  late final MethodOfPreparationModel methodOfPreparation;
  late final List<String> categories;

  RecipeCreationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = List.castFrom<dynamic, String>(json['images']);
    difficulty = json['difficulty'];
    serves = json['serves'];
    chefTips = json['chefTips'];
    ingredients = List.from(json['ingredients'])
        .map((e) => IngredientModel.fromJson(e))
        .toList();
    methodOfPreparation =
        MethodOfPreparationModel.fromJson(json['methodOfPreparation']);
    categories = List.castFrom<dynamic, String>(json['categories']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['images'] = images;
    _data['difficulty'] = difficulty;
    _data['serves'] = serves;
    _data['chefTips'] = chefTips;
    _data['ingredients'] = ingredients.map((e) => e.toJson()).toList();
    _data['methodOfPreparation'] = methodOfPreparation.toJson();
    _data['categories'] = categories;
    return _data;
  }
}
