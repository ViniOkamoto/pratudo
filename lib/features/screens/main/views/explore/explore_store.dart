import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

part 'explore_store.g.dart';

class ExploreStore = _ExploreStoreBase with _$ExploreStore;

abstract class _ExploreStoreBase with Store {
  final RecipeRepository _recipeRepository;
  _ExploreStoreBase(this._recipeRepository);

  @observable
  int currentIndex = 0;

  @observable
  bool hasError = false;

  @observable
  bool isLoading = false;

  ObservableList<SummaryRecipe> recipes = ObservableList();

  @action
  getLatestRecipe() async {
    isLoading = true;
    final result = await _recipeRepository.getLatestRecipes();

    result.fold(
      (l) => hasError,
      (r) => recipes.addAll(r),
    );

    isLoading = false;
  }
}
