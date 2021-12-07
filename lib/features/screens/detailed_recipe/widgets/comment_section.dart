import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/date_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/comment_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/comment_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_detailed_sections_title.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/profile_circle.dart';
import 'package:pratudo/features/widgets/app_field.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({
    Key? key,
    required this.recipeId,
  }) : super(key: key);

  final String recipeId;

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final RecipeCommentStore recipeCommentStore =
      serviceLocator<RecipeCommentStore>();
  @override
  void initState() {
    recipeCommentStore.getRecipeComments(widget.recipeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailedSectionsTitle(
          icon: LineAwesomeIcons.sms,
          text: 'Comentários',
        ),
        Observer(
          builder: (context) {
            if (recipeCommentStore.isLoading) {
              return CommentLoadingShimmer();
            }
            return ListView.separated(
              padding: EdgeInsets.only(
                left: SizeConverter.relativeWidth(8),
                top: SizeConverter.relativeHeight(16),
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                CommentModel comment = recipeCommentStore.comments[index];
                return CommentTile(
                  comment: comment,
                  onTapReply: recipeCommentStore.setReplyingComment,
                );
              },
              separatorBuilder: (context, index) => Column(
                children: [
                  Divider(
                    color: AppColors.greyColor,
                  ),
                ],
              ),
              itemCount: recipeCommentStore.comments.length,
            );
          },
        ),
        Spacing(height: 16),
        Observer(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (recipeCommentStore.replyingComment != null) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: CustomText(
                          text:
                              'Respondendo *${recipeCommentStore.replyingComment!.owner}*',
                          style: AppTypo.p4(color: AppColors.darkColor),
                        ),
                      ),
                      Spacing(width: 8),
                      InkWell(
                        onTap: () {
                          recipeCommentStore.unSetReplyingComment();
                        },
                        child: Text(
                          'Cancelar',
                          style: AppTypo.p5(color: AppColors.blueColor),
                        ),
                      ),
                    ],
                  ),
                  Spacing(
                    height: 8,
                  )
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppField(
                        focusNode: recipeCommentStore.focusNode,
                        onChanged: recipeCommentStore.setComment,
                        isBigTextField: true,
                        onSubmitted: (text) {
                          if (recipeCommentStore.canComment)
                            recipeCommentStore.submitComment(
                              widget.recipeId,
                              context,
                            );
                        },
                        controller: recipeCommentStore.commentController,
                        hintText: 'Adicione um comentário',
                      ),
                    ),
                    IconButton(
                      iconSize: SizeConverter.fontSize(24),
                      color: recipeCommentStore.canComment
                          ? AppColors.highlightColor
                          : AppColors.greyColor,
                      icon: Icon(
                        LineAwesomeIcons.paper_plane,
                      ),
                      onPressed: () => recipeCommentStore.submitComment(
                        widget.recipeId,
                        context,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CommentLoadingShimmer extends StatelessWidget {
  const CommentLoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConverter.relativeWidth(8),
        top: SizeConverter.relativeHeight(16),
      ),
      child: LoadingShimmer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBox(
              height: 32,
              width: 32,
              shape: BoxShape.circle,
            ),
            Spacing(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing(height: 8),
                  ShimmerBox(
                    height: 15,
                  ),
                  Spacing(height: 8),
                  ShimmerBox(
                    height: 10,
                    width: double.infinity,
                  ),
                  Spacing(height: 4),
                  ShimmerBox(
                    height: 10,
                    width: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.comment,
    required this.onTapReply,
  }) : super(key: key);

  final CommentModel comment;
  final Function(CommentModel) onTapReply;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileCircle(size: 32),
        Spacing(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      comment.owner,
                      style: AppTypo.h3(color: AppColors.darkerColor),
                    ),
                  ),
                  Text(
                    'em ${DateHelper.formatDateToString(
                      DateTime.parse(comment.creationDate),
                    )}',
                    style: AppTypo.a2(color: Colors.grey),
                  ),
                ],
              ),
              Spacing(height: 8),
              Text(
                comment.content,
                style: AppTypo.p4(color: AppColors.darkColor),
              ),
              Spacing(height: 4),
              InkWell(
                onTap: () {
                  onTapReply(comment);
                },
                child: Text(
                  'Responder',
                  style: AppTypo.p5(color: AppColors.blueColor),
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.only(
                  top: SizeConverter.relativeHeight(16),
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  RepliesModel comment = this.comment.replies[index];
                  return ReplyTile(comment: comment);
                },
                separatorBuilder: (context, index) => Column(
                  children: [
                    Divider(
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
                itemCount: comment.replies.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyTile extends StatelessWidget {
  const ReplyTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final RepliesModel comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeConverter.relativeHeight(2)),
          child: ProfileCircle(size: 24),
        ),
        Spacing(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      comment.owner,
                      style: AppTypo.h3(color: AppColors.darkerColor),
                    ),
                  ),
                  Text(
                    'em ${DateHelper.formatDateToString(
                      DateTime.parse(comment.creationDate),
                    )}',
                    style: AppTypo.a2(color: Colors.grey),
                  ),
                ],
              ),
              Spacing(height: 8),
              Text(
                comment.content,
                style: AppTypo.p4(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
