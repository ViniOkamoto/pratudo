import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/repositories/cache_recipe_repository.dart';

part 'cached_recipes_store.g.dart';

class CachedRecipesStore = _CachedRecipesStoreBase with _$CachedRecipesStore;

abstract class _CachedRecipesStoreBase with Store {
  final CacheRecipeRepository _recipeRepository;
  _CachedRecipesStoreBase(this._recipeRepository);

  @observable
  int currentIndex = 0;

  @observable
  bool hasError = false;

  @observable
  bool isLoading = true;

  ObservableList<CacheRecipeModel> recipes = ObservableList();

  @action
  getRecipes() async {
    isLoading = true;
    hasError = false;
    recipes.clear();
    currentIndex = 0;
    final result = await _recipeRepository.getCachedRecipes();

    result.fold(
      (l) => hasError = true,
      (r) => recipes.addAll(r),
    );

    isLoading = false;
  }
}
