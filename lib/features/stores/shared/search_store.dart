import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final RecipeRepository _repository;
  _SearchStoreBase(this._repository);

  final TextEditingController searchController = TextEditingController();

  @observable
  String? searchText;

  @observable
  bool isSearching = false;

  @observable
  bool hasErrorInSearch = false;

  @observable
  bool isLoadingSearch = false;

  @computed
  bool get isEmptyRecipe => filteredRecipes.isEmpty && !isLoadingSearch;

  ObservableList<SummaryRecipe> filteredRecipes = ObservableList();

  @action
  setSearchText(String value) => _setSearchText(value);

  _setSearchText(String value) {
    searchText = value;
    if (searchText!.isEmpty) {
      if (isSearching) isSearching = false;
    }
  }

  clearSearch() {
    setSearchText("");
    searchController.clear();
  }

  @action
  getRecipeByText() async {
    if (searchText?.isNotEmpty ?? false) {
      isLoadingSearch = true;
      hasErrorInSearch = false;
      isSearching = true;
      filteredRecipes.clear();
      await _getRecipeByText();

      isLoadingSearch = false;
    }
  }

  @action
  getFilteredRecipes({
    FilteredIngredientsEnum? searchType,
    List<String>? ingredients,
    RecipeHelperModel? category,
  }) async {
    isLoadingSearch = true;
    hasErrorInSearch = false;
    await _getRecipe(ingredients, category);
    isLoadingSearch = false;
  }

  _getRecipeByText() async {
    final result = await _repository.getRecipe(RecipeQueryParams(name: searchText!));
    result.fold(
      (l) => hasErrorInSearch = true,
      (r) {
        filteredRecipes.addAll(r);
      },
    );
  }

  @action
  _getRecipe(
    List<String>? ingredients,
    RecipeHelperModel? category,
  ) async {
    final result = await _repository.getRecipe(
      RecipeQueryParams(
        ingredients: ingredients ?? [],
        categories: category != null ? [category.key] : [],
      ),
    );
    result.fold(
      (l) => hasErrorInSearch = true,
      (r) {
        filteredRecipes.addAll(r);
      },
    );
  }
}
