import 'package:mobx/mobx.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

part 'comment_recipe_store.g.dart';

class RecipeCommentStore = _RecipeCommentStoreBase with _$RecipeCommentStore;

abstract class _RecipeCommentStoreBase with Store {
  final DetailedRecipeRepository _detailedRecipeRepository;
  final GamificationObserver _gamificationObserver;

  _RecipeCommentStoreBase(
    this._detailedRecipeRepository,
    this._gamificationObserver,
  );
}
