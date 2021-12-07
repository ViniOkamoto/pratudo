import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pratudo/core/utils/flutter_toast_helper.dart';
import 'package:pratudo/features/models/recipe/comment_model.dart';
import 'package:pratudo/features/repositories/detailed_recipe_repository.dart';
import 'package:pratudo/features/screens/main/main_page.dart';
import 'package:pratudo/features/screens/shared/step_by_step/widgets/rate_and_comment/rate_and_comment_modal.dart';
import 'package:pratudo/features/stores/shared/gamification_observer.dart';

part 'comment_recipe_store.g.dart';

class RecipeCommentStore = _RecipeCommentStoreBase with _$RecipeCommentStore;

abstract class _RecipeCommentStoreBase with Store {
  final DetailedRecipeRepository _detailedRecipeRepository;
  final GamificationObserver _gamificationObserver;
  final TextEditingController commentController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  _RecipeCommentStoreBase(
    this._detailedRecipeRepository,
    this._gamificationObserver,
  );

  @observable
  bool isLoading = false;

  @observable
  bool isSending = false;

  @observable
  bool hasError = false;

  @observable
  String commentText = '';

  @computed
  bool get canComment => !isSending && commentText.isNotEmpty;

  @action
  setComment(String value) => commentText = value;

  @observable
  ObservableList<CommentModel> comments = ObservableList();

  @observable
  CommentModel? replyingComment;

  @action
  setReplyingComment(CommentModel commentModel) {
    replyingComment = commentModel;
    focusNode.requestFocus();
  }

  @action
  unSetReplyingComment() {
    replyingComment = null;
    focusNode.unfocus();
  }

  getRecipeComments(String recipeId) async {
    isLoading = true;
    hasError = false;
    comments.clear();

    final result = await _detailedRecipeRepository.getRecipeComments(recipeId);

    result.fold(
      (l) => FlutterToastHelper(text: l.errorText),
      (r) => comments.addAll(r),
    );
    isLoading = false;
  }

  submitComment(String recipeId, BuildContext context) async {
    isSending = true;
    focusNode.unfocus();

    if (replyingComment != null) {
      await replyComment(recipeId);
    } else {
      await commentRecipe(recipeId, context);
    }

    isSending = false;
  }

  commentRecipe(String recipeId, BuildContext context) async {
    final result = await _gamificationObserver.callWithGamificationResponse(
      _detailedRecipeRepository.commentRecipe(commentText, recipeId),
    );

    result.fold(
      (l) => FlutterToastHelper.failToast(text: l.errorText),
      (r) {
        commentController.text = '';
        commentText = '';
        getRecipeComments(recipeId);
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

  replyComment(String recipeId) async {
    final result = await _detailedRecipeRepository.replyComment(
      commentText,
      recipeId,
      replyingComment!.id,
    );

    result.fold(
      (l) => FlutterToastHelper.failToast(text: l.errorText),
      (r) {
        replyingComment = null;
        commentController.text = '';
        commentText = '';
        getRecipeComments(recipeId);
      },
    );
  }
}
