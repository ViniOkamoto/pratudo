import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/repositories/cache_recipe_repository.dart';

part 'detailed_cache_recipe_store.g.dart';

class DetailedCacheRecipeStore = _DetailedCacheRecipeStoreBase
    with _$DetailedCacheRecipeStore;

abstract class _DetailedCacheRecipeStoreBase with Store {
  final CacheRecipeRepository _cacheRecipe;
  _DetailedCacheRecipeStoreBase(this._cacheRecipe);

  @observable
  bool isCachedRecipe = false;

  @observable
  CacheRecipeModel? recipeModel;

  checkIfRecipeIsCached() async {
    final result = await _cacheRecipe.checkIfIsCached(recipeModel!.id);
    result.fold((l) => isCachedRecipe = false, (r) => isCachedRecipe = r);
  }

  void cacheRecipe() async {
    final result = await _cacheRecipe.saveRecipe(recipeModel!);

    result.fold(
      (l) => FlutterToastHelper.failToast(text: 'Falha ao tentar salvar'),
      (r) => isCachedRecipe = true,
    );
  }

  void removeCachedRecipe() async {
    final result = await _cacheRecipe.deleteRecipeById(recipeModel!.id);

    result.fold(
      (l) => FlutterToastHelper.failToast(text: 'Falha ao tentar deletar'),
      (r) => isCachedRecipe = false,
    );
  }
}
