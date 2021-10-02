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
  String? searchText;

  Timer? _debounceSearchText;

  @action
  setSearchText(String value) => _setSearchText(value);

  _setSearchText(String value) {
    searchText = value;
    if (searchText!.isEmpty) {
      if (isSearching) isSearching = false;
    }
  }

  @observable
  int currentIndex = 0;

  @observable
  bool hasError = false;

  @observable
  bool hasErrorInSearch = false;

  @observable
  bool isLoadingSearch = false;

  @observable
  bool isSearching = false;

  @observable
  bool isLoading = false;

  ObservableList<SummaryRecipe> recipes = ObservableList();

  ObservableList<SummaryRecipe> filteredRecipes = ObservableList();

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

  @action
  getFilteredRecipes() async {
    if (searchText!.isNotEmpty) {
      isLoadingSearch = true;
      hasErrorInSearch = false;
      isSearching = true;
      filteredRecipes.clear();

      final result = await _recipeRepository.getFilteredRecipes(searchText!);
      result.fold(
        (l) => hasErrorInSearch,
        (r) {
          filteredRecipes.addAll(r);
        },
      );

      isLoadingSearch = false;
    }
  }
}
