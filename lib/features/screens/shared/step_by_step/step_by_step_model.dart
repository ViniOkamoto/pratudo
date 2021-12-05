import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/step_model.dart';

class StepByStepModel {
  final String recipeId;
  final String name;
  final String chefTips;
  final List<IngredientModel> ingredients;
  final List<StepModel> steps;

  StepByStepModel({
    required this.recipeId,
    required this.name,
    required this.chefTips,
    required this.ingredients,
    required this.steps,
  });
}
