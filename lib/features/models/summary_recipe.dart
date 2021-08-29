import 'package:pratudo/features/models/owner_recipe.dart';

class SummaryRecipe {
  final String id;
  final String name;
  final RecipeOwner recipeOwner;
  final String difficulty;
  final double rate;
  final List<String> images;

  SummaryRecipe({
    required this.id,
    required this.name,
    required this.recipeOwner,
    required this.difficulty,
    required this.rate,
    required this.images,
  });

  static SummaryRecipe fromJson(Map<String, dynamic> json) => SummaryRecipe(
        id: json['_id'],
        name: json['name'],
        images: json['images'].cast<String>(),
        recipeOwner: RecipeOwner.fromJson(json['owner']),
        difficulty: json['difficulty'],
        rate: json['rate'],
      );

  static List<SummaryRecipe> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
