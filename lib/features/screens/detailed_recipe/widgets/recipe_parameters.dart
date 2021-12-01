import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';

class RecipeParameters extends StatelessWidget {
  const RecipeParameters({Key? key, required this.detailedRecipeModel})
      : super(key: key);
  final DetailedRecipeModel detailedRecipeModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RecipeParameter(
          value: parseStringToEnum[detailedRecipeModel.difficulty]!,
          label: 'Dificuldade',
        ),
        CustomVerticalDivider(),
        RecipeParameter(
          value: detailedRecipeModel.totalMethodOfPreparationTime
              .convertTimeToString(),
          label: 'Tempo',
        ),
        CustomVerticalDivider(),
        RecipeParameter(
          value: '${detailedRecipeModel.totalIngredients}',
          label: 'Ingredientes',
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21,
      child: VerticalDivider(
        color: AppColors.lightGrayColor,
        thickness: 2,
        width: 2,
      ),
    );
  }
}

class RecipeParameter extends StatelessWidget {
  const RecipeParameter({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypo.h2(color: AppColors.darkestColor),
        ),
        Text(
          label,
          style: AppTypo.p3(color: AppColors.greyColor),
        ),
      ],
    );
  }
}
