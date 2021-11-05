import 'package:pratudo/core/utils/enums/time_enum.dart';
import 'package:pratudo/features/models/recipe/owner_recipe.dart';
import 'package:pratudo/features/models/recipe/preparation_time.dart';

class SummaryRecipe {
  final String id;
  final String name;
  final RecipeOwner recipeOwner;
  final String difficulty;
  final double rate;
  final int serves;
  final List<String> images;
  final PreparationTime preparationTime;
  final List<String>? tags;
  final bool isNew;

  SummaryRecipe({
    required this.id,
    required this.name,
    required this.recipeOwner,
    required this.difficulty,
    required this.rate,
    required this.images,
    required this.preparationTime,
    required this.isNew,
    required this.serves,
    required this.tags,
  });

  String get preparationTimeToString =>
      "${preparationTime.value} ${parseStringToEnum(preparationTime.unit)!.parseToStringFront}";

  String get portions => "$serves ${serves > 1 ? 'porções' : 'porção'}";

  static SummaryRecipe fromJson(Map<String, dynamic> json) => SummaryRecipe(
        id: json['_id'],
        name: json['name'],
        images: json['images'].cast<String>(),
        recipeOwner: RecipeOwner.fromJson(json['owner']),
        difficulty: json['difficulty'],
        rate: json['rate'],
        serves: json['serves'],
        preparationTime: PreparationTime.fromJson(json['totalMethodOfPreparationTime']),
        tags: json['tags']?.cast<String>(),
        isNew: json['isNew'],
      );

  static List<SummaryRecipe> fromJsonList(List<dynamic> json) {
    return json.map((i) => fromJson(i)).toList();
  }
}
