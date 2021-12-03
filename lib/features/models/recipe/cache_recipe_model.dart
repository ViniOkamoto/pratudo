import 'package:hive/hive.dart';
import 'package:pratudo/core/services/hive/hive_names_helper.dart';
import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/method_of_preparation_model.dart';
import 'package:pratudo/features/models/recipe/owner_recipe.dart';
import 'package:pratudo/features/models/time_model.dart';

part 'cache_recipe_model.g.dart';

@HiveType(typeId: RecipeHiveHelper.type)
class CacheRecipeModel extends HiveObject {
  CacheRecipeModel({
    required this.id,
    required this.name,
    required this.images,
    required this.owner,
    required this.difficulty,
    required this.serves,
    required this.chefTips,
    required this.ingredients,
    required this.methodOfPreparation,
    required this.categories,
    required this.rate,
    required this.totalMethodOfPreparationTime,
  });

  @HiveField(RecipeHiveHelper.idField)
  late final String id;
  @HiveField(RecipeHiveHelper.nameField)
  late final String name;
  @HiveField(RecipeHiveHelper.imagesField)
  late final List<String> images;
  @HiveField(RecipeHiveHelper.ownerField)
  late final RecipeOwner owner;
  @HiveField(RecipeHiveHelper.difficultyField)
  late final String difficulty;
  @HiveField(RecipeHiveHelper.servesField)
  late final int serves;
  @HiveField(RecipeHiveHelper.chefTipsField)
  late final String chefTips;
  @HiveField(RecipeHiveHelper.ingredientsField)
  late final List<IngredientModel> ingredients;
  @HiveField(RecipeHiveHelper.methodOfPreparationField)
  late final MethodOfPreparationModel methodOfPreparation;
  @HiveField(RecipeHiveHelper.categoriesField)
  late final List<String> categories;
  @HiveField(RecipeHiveHelper.rateField)
  late final double rate;
  @HiveField(RecipeHiveHelper.totalMethodOfPreparationField)
  late final TimeModel totalMethodOfPreparationTime;

  String get portions => "$serves ${serves > 1 ? 'Porções' : 'Porção'}";

  int get totalIngredients {
    int total = 0;
    ingredients.forEach((element) {
      total += element.items!.length;
    });
    return total;
  }
}
