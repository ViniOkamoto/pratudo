import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/core/utils/loading_overlay.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/create_recipe/recipe_info_model.dart';
import 'package:pratudo/features/models/create_recipe/section_model.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

part 'create_recipe_store.g.dart';

class CreateRecipeStore = _CreateRecipeStoreBase with _$CreateRecipeStore;

abstract class _CreateRecipeStoreBase with Store {
  final GamificationObserver _gamificationObserver;
  final RecipeRepository _repository;

  _CreateRecipeStoreBase(this._gamificationObserver, this._repository);

  Future<ExperienceGainedModel?> submitRecipe(RecipeInfoModel recipe, List<SectionModel> recipeSections) async {
    final RecipeCreationModel recipeCreation = serializeRecipeCreationModel(recipe, recipeSections);

    final result = await LoadingOverlay.of().during(
      _gamificationObserver.callWithGamificationResponse(
        _repository.createRecipe(recipeCreation),
      ),
    );

    return result.fold(
      (l) {
        FlutterToastHelper.failToast(text: l.errorText);
        return null;
      },
      (r) => r,
    );
  }

  RecipeCreationModel serializeRecipeCreationModel(RecipeInfoModel recipe, List<SectionModel> recipeSections) {
    List<String> categories = recipe.categories.map((e) => e.key).toList();
    List<Ingredient> ingredients = [];
    List<Step> steps = [];
    recipeSections.forEach(
      (section) {
        final step = Step(
          step: section.sectionName!,
          time: Time(
            value: section.time,
            unit: section.unit!,
          ),
          items: section.steps,
        );
        steps.add(step);
        final ingredient = Ingredient(
          step: section.sectionName,
          items: section.ingredients
              .map(
                (e) => Items(
                  name: e.name!,
                  portion: e.portion!,
                ),
              )
              .toList(),
        );
        ingredients.add(ingredient);
      },
    );
    final RecipeCreationModel recipeCreationModel = RecipeCreationModel(
      name: recipe.recipeName,
      images: [recipe.image],
      difficulty: recipe.difficulty.key,
      serves: recipe.portions,
      chefTips: recipe.chefTip ?? '',
      categories: categories,
      ingredients: ingredients,
      methodOfPreparation: MethodOfPreparation(
        steps: steps,
      ),
    );
    return recipeCreationModel;
  }
}
