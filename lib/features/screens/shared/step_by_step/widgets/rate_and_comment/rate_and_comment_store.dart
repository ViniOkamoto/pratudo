import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/core/utils/loading_overlay.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/screens/main/main_page.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_modal.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

part 'rate_and_comment_store.g.dart';

class RateAndCommentStore = _RateAndCommentStoreBase with _$RateAndCommentStore;

abstract class _RateAndCommentStoreBase with Store {
  final DetailedRecipeRepository _repository;
  final GamificationObserver _gamificationObserver;
  _RateAndCommentStoreBase(this._repository, this._gamificationObserver);

  final TextEditingController commentController = TextEditingController();

  @observable
  double rate = 0;

  @action
  setRate(double value) => rate = value;

  @observable
  String content = '';

  @action
  setContent(String value) => content = value;

  rateAndComment(String id, BuildContext context) async {
    final result = await LoadingOverlay.of().during(
      _gamificationObserver.callWithGamificationResponse(
        _repository.rateAndCommentRecipe(content, id, rate),
      ),
    );
    result.fold(
      (l) => FlutterToastHelper.failToast(text: l.errorText),
      (r) {
        LoadingOverlay.of().hide();
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
