import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  final RecipeRepository _repository;
  _SearchStoreBase(this._repository);

  final TextEditingController searchController = TextEditingController();

  @observable
  String? searchText = '';

  @observable
  List<String> categories = [];

  @observable
  List<String> difficulties = [];

  @observable
  List<String> ingredients = [];

  @observable
  String portions = '';

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
      clearFilters();
      if (isSearching) isSearching = false;
    }
  }

  clearSearch() {
    setSearchText("");
    clearFilters();
    searchController.clear();
  }

  clearFilters() {
    difficulties = [];
    categories = [];
    portions = '';
    isSearching = false;
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
  getFilteredRecipes(
    RecipeQueryParams recipeQueryParams,
  ) async {
    isLoadingSearch = true;
    hasErrorInSearch = false;
    isSearching = true;
    await _getRecipe(
      RecipeQueryParams(
        ingredients: recipeQueryParams.ingredients ?? ingredients,
        categories: recipeQueryParams.categories ?? categories,
        difficulties: recipeQueryParams.difficulties ?? difficulties,
        portions: recipeQueryParams.portions ?? portions,
        name: recipeQueryParams.name ?? searchText ?? '',
      ),
    );
    isLoadingSearch = false;
  }

  _getRecipeByText() async {
    final result = await _repository.getRecipe(RecipeQueryParams(
      name: searchText!,
    ));
    result.fold(
      (l) => hasErrorInSearch = true,
      (r) {
        filteredRecipes.addAll(r);
      },
    );
  }

  setFilters(RecipeQueryParams recipeQueryParams) {
    categories = recipeQueryParams.categories!;
    difficulties = recipeQueryParams.difficulties!;
    ingredients = recipeQueryParams.ingredients!;
    portions = recipeQueryParams.portions!;
  }

  unsetDifficulties() {
    getFilteredRecipes(
      RecipeQueryParams(
        difficulties: [],
      ),
    );
  }

  unsetCategories() {
    getFilteredRecipes(
      RecipeQueryParams(
        categories: [],
      ),
    );
  }

  unsetPortion() {
    getFilteredRecipes(
      RecipeQueryParams(
        portions: '',
      ),
    );
  }

  @action
  _getRecipe(
    RecipeQueryParams recipeQueryParams,
  ) async {
    setFilters(recipeQueryParams);
    if (checkIfAllFiltersIsEmpty()) {
      isSearching = false;
    } else {
      filteredRecipes.clear();
      final result = await _repository.getRecipe(recipeQueryParams);
      result.fold(
        (l) => hasErrorInSearch = true,
        (r) {
          filteredRecipes.addAll(r);
        },
      );
    }
  }

  checkIfAllFiltersIsEmpty() {
    return difficulties.isEmpty &&
        categories.isEmpty &&
        ingredients.isEmpty &&
        portions.isEmpty &&
        (searchText?.isEmpty ?? true);
  }
}
