import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/date_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/comment_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_detailed_sections_title.dart';
import 'package:pratudo/features/screens/main/views/profile/widgets/profile_circle.dart';
import 'package:pratudo/features/widgets/app_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({
    Key? key,
    required this.comments,
  }) : super(key: key);

  final List<CommentModel> comments;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailedSectionsTitle(
          icon: LineAwesomeIcons.sms,
          text: 'Comentários',
        ),
        if (comments.isNotEmpty) Spacing(height: 16),
        ListView.separated(
          padding: EdgeInsets.only(left: 8),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            CommentModel comment = comments[index];
            return CommentTile(comment: comment);
          },
          separatorBuilder: (context, index) => Column(
            children: [
              Divider(
                color: AppColors.greyColor,
              ),
            ],
          ),
          itemCount: comments.length,
        ),
        Spacing(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppField(
                focusNode: FocusNode(),
                onChanged: (value) {},
                isBigTextField: true,
                onSubmitted: (text) {
                  // if (canSubmit) onSubmit();
                },
                controller: TextEditingController(),
                hintText: 'Adicione um comentário',
              ),
            ),
            IconButton(
              iconSize: SizeConverter.fontSize(24),
              color: AppColors.highlightColor,
              icon: Icon(
                LineAwesomeIcons.paper_plane,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final CommentModel comment;

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
