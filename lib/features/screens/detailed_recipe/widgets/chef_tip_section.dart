import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_detailed_sections_title.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:readmore/readmore.dart';

class ChefTipSection extends StatelessWidget {
  const ChefTipSection({
    Key? key,
    required this.text,
    this.trimLines = 3,
  }) : super(key: key);

  final String text;
  final int trimLines;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipeDetailedSectionsTitle(
          icon: LineAwesomeIcons.hand_holding_heart,
          text: 'Dica do chefe',
        ),
        Spacing(height: 8),
        Padding(
          padding: EdgeInsets.only(
            left: SizeConverter.relativeWidth(16),
          ),
          child: ReadMoreText(
            text,
            trimLines: trimLines,
            trimMode: TrimMode.Line,
            colorClickableText: AppColors.highlightColor,
            style: AppTypo.p3(color: AppColors.darkColor),
            trimCollapsedText: 'Mostrar mais',
            trimExpandedText: 'Mostrar menos',
          ),
        ),
      ],
    );
  }
}
