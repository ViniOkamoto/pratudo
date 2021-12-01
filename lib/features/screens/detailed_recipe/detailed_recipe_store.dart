import 'package:mobx/mobx.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

part 'detailed_recipe_store.g.dart';

class DetailedRecipeStore = _DetailedRecipeStoreBase with _$DetailedRecipeStore;

abstract class _DetailedRecipeStoreBase with Store {
  final RecipeRepository _repository;
  _DetailedRecipeStoreBase(this._repository);

  @observable
  bool isLoading = true;

  @observable
  bool hasError = false;

  @observable
  DetailedRecipeModel? detailedRecipeModel;

  Future<void> getRecipe(String id) async {
    isLoading = true;
    hasError = false;
    final result = await _repository.getRecipeById(id);
    result.fold(
      (l) => hasError = true,
      (r) => detailedRecipeModel = r,
    );
    isLoading = false;
  }
}
