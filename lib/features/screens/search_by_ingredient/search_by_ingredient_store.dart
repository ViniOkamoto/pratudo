import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_page.dart';

part 'search_by_ingredient_store.g.dart';

class SearchByIngredientStore = _SearchByIngredientStoreBase with _$SearchByIngredientStore;

abstract class _SearchByIngredientStoreBase with Store {
  final TextEditingController ingredientField = TextEditingController();

  @observable
  String? ingredient;

  @observable
  String errorText = '';

  @observable
  ObservableList<String> ingredients = ObservableList();

  @computed
  bool get validSearch => ingredients.length >= 2;

  @action
  setIngredient(String value) => _setIngredients(value);

  _setIngredients(String value) {
    errorText = '';
    ingredient = value;
  }

  @action
  addIngredient() {
    if (ingredient?.isNotEmpty ?? false) {
      ingredients.add(ingredient!);
      ingredient = '';
      ingredientField.clear();
    } else {
      errorText = 'O campo não pode estar vazio';
    }
  }

  @action
  removeIngredient(index) {
    ingredients.removeAt(index);
  }

  dynamic findRecipe(BuildContext context) async {
    Navigator.pushNamed(
      context,
      Routes.filteredIngredients,
      arguments: FilteredIngredientsPageParams(
        FilteredIngredientsEnum.INGREDIENTS,
        ingredients: ingredients,
      ),
    );
  }
}
