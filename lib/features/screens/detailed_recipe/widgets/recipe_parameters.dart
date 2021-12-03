import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/time_model.dart';

class RecipeParameters extends StatelessWidget {
  const RecipeParameters({
    Key? key,
    required this.difficulty,
    required this.time,
    required this.totalIngredients,
  }) : super(key: key);

  final String difficulty;
  final TimeModel time;
  final int totalIngredients;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RecipeParameter(
          value: parseStringToEnum[difficulty]!,
          label: 'Dificuldade',
        ),
        CustomVerticalDivider(),
        RecipeParameter(
          value: time.convertTimeToString(),
          label: 'Tempo',
        ),
        CustomVerticalDivider(),
        RecipeParameter(
          value: '$totalIngredients',
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
