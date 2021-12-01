import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/method_of_preparation_model.dart';
import 'package:pratudo/features/models/recipe/owner_recipe.dart';
import 'package:pratudo/features/models/time_model.dart';

class DetailedRecipeModel {
  DetailedRecipeModel({
    required this.id,
    required this.name,
    required this.images,
    required this.owner,
    required this.difficulty,
    required this.serves,
    required this.creationDate,
    required this.chefTips,
    required this.ratings,
    required this.isUserAllowedToRate,
    required this.ingredients,
    required this.methodOfPreparation,
    required this.comments,
    this.tags,
    required this.categories,
    required this.rate,
    required this.totalMethodOfPreparationTime,
    required this.isNew,
  });
  late final String id;
  late final String name;
  late final List<String> images;
  late final RecipeOwner owner;
  late final String difficulty;
  late final int serves;
  late final String creationDate;
  late final String chefTips;
  late final List<dynamic> ratings;
  late final bool isUserAllowedToRate;
  late final List<IngredientModel> ingredients;
  late final MethodOfPreparationModel methodOfPreparation;
  late final List<dynamic> comments;
  late final Null tags;
  late final List<String> categories;
  late final double rate;
  late final TimeModel totalMethodOfPreparationTime;
  late final bool isNew;

  String get portions => "$serves ${serves > 1 ? 'Porções' : 'Porção'}";

  int get totalIngredients {
    int total = 0;
    ingredients.forEach((element) {
      total += element.items!.length;
    });
    return total;
  }

  DetailedRecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    images = List.castFrom<dynamic, String>(json['images']);
    owner = RecipeOwner.fromJson(json['owner']);
    difficulty = json['difficulty'];
    serves = json['serves'];
    creationDate = json['creationDate'];
    chefTips = json['chefTips'];
    ratings = List.castFrom<dynamic, dynamic>(json['ratings']);
    isUserAllowedToRate = json['isUserAllowedToRate'];
    ingredients = List.from(json['ingredients'])
        .map((e) => IngredientModel.fromJson(e))
        .toList();
    methodOfPreparation =
        MethodOfPreparationModel.fromJson(json['methodOfPreparation']);
    comments = List.castFrom<dynamic, dynamic>(json['comments']);
    tags = null;
    categories = List.castFrom<dynamic, String>(json['categories']);
    rate = json['rate'].toDouble();
    totalMethodOfPreparationTime =
        TimeModel.fromJson(json['totalMethodOfPreparationTime']);
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['images'] = images;
    _data['owner'] = owner.toJson();
    _data['difficulty'] = difficulty;
    _data['serves'] = serves;
    _data['creationDate'] = creationDate;
    _data['chefTips'] = chefTips;
    _data['ratings'] = ratings;
    _data['isUserAllowedToRate'] = isUserAllowedToRate;
    _data['ingredients'] = ingredients.map((e) => e.toJson()).toList();
    _data['methodOfPreparation'] = methodOfPreparation.toJson();
    _data['comments'] = comments;
    _data['tags'] = tags;
    _data['categories'] = categories;
    _data['rate'] = rate;
    _data['totalMethodOfPreparationTime'] =
        totalMethodOfPreparationTime.toJson();
    _data['isNew'] = isNew;
    return _data;
  }
}
