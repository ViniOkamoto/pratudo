import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/repositories/cache_recipe_repository.dart';
import 'package:pratudo/features/repositories/recipe_repository.dart';

part 'detailed_recipe_store.g.dart';

class DetailedRecipeStore = _DetailedRecipeStoreBase with _$DetailedRecipeStore;

abstract class _DetailedRecipeStoreBase with Store {
  final RecipeRepository _repository;
  final CacheRecipeRepository _cacheRecipe;

  _DetailedRecipeStoreBase(this._repository, this._cacheRecipe);

  @observable
  bool isLoading = true;

  @observable
  bool hasError = false;

  @observable
  bool isCachedRecipe = false;

  @observable
  DetailedRecipeModel? detailedRecipeModel;

  Future<void> getRecipe(String id) async {
    isLoading = true;
    hasError = false;
    final result = await _repository.getRecipeById(id);
    result.fold(
      (l) => hasError = true,
      (r) async {
        detailedRecipeModel = r;
        await checkIfRecipeIsCached();
      },
    );
    isLoading = false;
  }

  checkIfRecipeIsCached() async {
    final result = await _cacheRecipe.checkIfIsCached(detailedRecipeModel!.id);
    result.fold((l) => isCachedRecipe = false, (r) => isCachedRecipe = r);
  }

  void cacheRecipe() async {
    DetailedRecipeModel recipe = detailedRecipeModel!;
    final result = await _cacheRecipe.saveRecipe(
      CacheRecipeModel(
        id: recipe.id,
        name: recipe.name,
        images: recipe.images,
        owner: recipe.owner,
        difficulty: recipe.difficulty,
        serves: recipe.serves,
        chefTips: recipe.chefTips,
        ingredients: recipe.ingredients,
        methodOfPreparation: recipe.methodOfPreparation,
        categories: recipe.categories,
        rate: recipe.rate,
        totalMethodOfPreparationTime: recipe.totalMethodOfPreparationTime,
      ),
    );

    result.fold(
      (l) => FlutterToastHelper.failToast(text: 'Falha ao tentar salvar'),
      (r) => isCachedRecipe = true,
    );
  }

  void removeCachedRecipe() async {
    final result = await _cacheRecipe.deleteRecipeById(detailedRecipeModel!.id);

    result.fold(
      (l) => FlutterToastHelper.failToast(text: 'Falha ao tentar deletar'),
      (r) => isCachedRecipe = false,
    );
  }
}
