import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';

class RecipeInfoModel {
  final String image;
  final String recipeName;
  final String? description;
  final List<RecipeHelperModel> categories;
  final DifficultyEnum difficulty;
  final int portions;
  final String? chefTip;

  RecipeInfoModel({
    required this.image,
    required this.recipeName,
    required this.description,
    required this.categories,
    required this.difficulty,
    required this.portions,
    required this.chefTip,
  });
}
