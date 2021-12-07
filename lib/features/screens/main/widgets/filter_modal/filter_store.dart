import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  @observable
  ObservableList<RecipeHelperModel> categories = ObservableList();

  @action
  setCategory(List<Object?> value) {
    List<RecipeHelperModel> recipeList = [];
    value.forEach((element) {
      recipeList.add(element as RecipeHelperModel);
    });
    this.categories.clear();
    categories.addAll(recipeList);
  }

  @action
  unsetCategory(Object? value) {
    categories.removeWhere(
        (element) => element.key == (value as RecipeHelperModel).key);
  }

  @observable
  ObservableList<DifficultyEnum> difficulties = ObservableList();

  @action
  setDifficulty(List<Object?> value) {
    List<DifficultyEnum> recipeList = [];
    value.forEach((element) {
      recipeList.add(element as DifficultyEnum);
    });
    this.difficulties.clear();
    difficulties.addAll(recipeList);
  }

  @action
  unsetDifficulty(Object? value) {
    difficulties
        .removeWhere((element) => element.key == (value as DifficultyEnum).key);
  }

  @observable
  int portion = 0;

  @action
  void onTapMore() {
    portion++;
  }

  @action
  void onTapLess() {
    if (portion > 0) {
      portion--;
    }
  }
}
