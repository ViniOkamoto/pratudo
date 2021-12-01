import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/icon_with_text.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class RecipeHeader extends StatelessWidget {
  const RecipeHeader({
    Key? key,
    required this.detailedRecipeModel,
  }) : super(key: key);
  final DetailedRecipeModel detailedRecipeModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              detailedRecipeModel.name,
              style: AppTypo.h1(color: AppColors.darkestColor),
            ),
            Spacing(width: 4),
            Icon(
              LineAwesomeIcons.star_1,
              size: SizeConverter.fontSize(20),
              color: AppColors.yellowColor,
            ),
            Text(
              '(${detailedRecipeModel.rate})',
              style: AppTypo.p3(color: AppColors.greyColor),
            ),
          ],
        ),
        CustomText(
          text: 'Feito por: *${detailedRecipeModel.owner.name}*',
          style: AppTypo.p4(color: AppColors.darkColor),
        ),
        Text(
          '40 visualizações',
          style: AppTypo.p4(color: AppColors.darkColor),
        ),
        Spacing(height: 8),
        IconWithText(
          icon: LineAwesomeIcons.user,
          color: AppColors.orangeColor,
          text: detailedRecipeModel.portions,
          textStyle: AppTypo.p5(color: AppColors.orangeColor),
          iconSize: 20,
        ),
        Spacing(height: 4),
        IconWithText(
          icon: LineAwesomeIcons.sms,
          color: AppColors.blueColor,
          text: '${detailedRecipeModel.comments.length} Comentários',
          textStyle: AppTypo.p5(color: AppColors.blueColor),
          iconSize: 20,
        ),
      ],
    );
  }
}
