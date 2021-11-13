import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/loading_overlay.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/repositories/recipe_helpers_repository.dart';

part 'recipe_helpers_store.g.dart';

class RecipeHelpersStore = _RecipeHelpersStoreBase with _$RecipeHelpersStore;

abstract class _RecipeHelpersStoreBase with Store {
  final RecipeHelperRepository _repository;
  _RecipeHelpersStoreBase(this._repository);

  @observable
  ObservableList<RecipeHelperModel> categories = ObservableList();

  @observable
  bool hasErrorInCategories = false;

  @observable
  bool isLoadingCategories = false;

  @observable
  ObservableList<RecipeHelperModel> filters = ObservableList();

  @observable
  bool hasErrorInFilters = false;

  @observable
  bool isLoadingFilters = false;

  @action
  getCategories({bool withLoadingOverlay = false, bool fetchingNewData = false}) async {
    if (fetchingNewData || categories.isEmpty) {
      isLoadingCategories = true;
      hasErrorInCategories = false;
      dynamic result;

      if (withLoadingOverlay) {
        result = await LoadingOverlay.of().during(_repository.getCategories());
      } else {
        result = await _repository.getCategories();
      }
      categories.clear();
      result.fold(
        (l) => hasErrorInCategories = true,
        (r) {
          categories.addAll(r);
        },
      );

      isLoadingCategories = false;
    }
  }

  @action
  getFilters() async {
    isLoadingFilters = true;
    hasErrorInFilters = false;
    filters.clear();
    final result = await _repository.getTrends();
    result.fold(
      (l) => hasErrorInFilters = true,
      (r) {
        filters.addAll(r);
      },
    );
    isLoadingFilters = false;
  }
}
