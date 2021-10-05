import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

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

  @action
  getFilteredRecipes() async {
    if (searchText!.isNotEmpty) {
      isLoadingSearch = true;
      hasErrorInSearch = false;
      isSearching = true;
      filteredRecipes.clear();

      final result = await _repository.getFilteredRecipes(searchText!);
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
