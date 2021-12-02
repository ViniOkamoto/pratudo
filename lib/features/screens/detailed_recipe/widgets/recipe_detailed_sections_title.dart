import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/features/widgets/icon_with_text.dart';

class RecipeDetailedSectionsTitle extends StatelessWidget {
  const RecipeDetailedSectionsTitle({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return IconWithText(
      icon: icon,
      color: AppColors.darkerColor,
      text: text,
      textStyle: AppTypo.h2(color: AppColors.darkerColor),
      iconSize: 26,
    );
  }
}
