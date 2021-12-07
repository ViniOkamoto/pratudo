import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

part 'my_recipes_store.g.dart';

class MyRecipesStore = _MyRecipesStoreBase with _$MyRecipesStore;

abstract class _MyRecipesStoreBase with Store {
  final RecipeRepository _recipeRepository;
  _MyRecipesStoreBase(this._recipeRepository);

  @observable
  int currentIndex = 0;

  @observable
  bool hasError = false;

  @observable
  bool isLoading = false;

  ObservableList<SummaryRecipe> recipes = ObservableList();

  @action
  getRecipes() async {
    isLoading = true;
    hasError = false;
    recipes.clear();
    final result = await _recipeRepository.myRecipes();

    result.fold(
      (l) => hasError = true,
      (r) => recipes.addAll(r),
    );

    isLoading = false;
  }
}
