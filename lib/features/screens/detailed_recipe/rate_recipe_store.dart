import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/core/utils/loading_overlay.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/screens/main/main_page.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_modal.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

part 'rate_recipe_store.g.dart';

class RecipeRateStore = _RecipeRateStoreBase with _$RecipeRateStore;

abstract class _RecipeRateStoreBase with Store {
  final DetailedRecipeRepository _repository;
  final GamificationObserver _gamificationObserver;

  _RecipeRateStoreBase(
    this._repository,
    this._gamificationObserver,
  );

  @observable
  double rate = 0;

  @action
  setRate(double value) => rate = value;

  rateRecipe(String id, BuildContext context) async {
    final result = await LoadingOverlay.of().during(
      _gamificationObserver.callWithGamificationResponse(
        _repository.rateRecipe(id, rate),
      ),
    );
    result.fold(
      (l) => FlutterToastHelper.failToast(text: l.errorText),
      (r) {
        Navigator.pop(context, true);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return GamificationNotifierModal(
              experienceGainedModel: r,
              bottom: Row(
                children: [
                  Expanded(
                    child: BackToRecipe(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
