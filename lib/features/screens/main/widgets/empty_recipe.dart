import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class EmptyRecipe extends StatelessWidget {
  const EmptyRecipe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
        vertical: SizeConverter.relativeHeight(16),
      ),
      child: Column(
        children: [
          Icon(
            LineAwesomeIcons.book,
            size: SizeConverter.fontSize(94),
            color: AppColors.highlightColor,
          ),
          Spacing(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Nenhuma receita encontrada.\n ',
              style: AppTypo.p3(color: AppColors.darkestColor),
              children: <TextSpan>[
                TextSpan(
                  text: 'O que acha de ',
                ),
                TextSpan(
                  text: 'compartilhar ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'alguma com a gente?',
                ),
              ],
            ),
          ),
          Spacing(height: 40),
          AppPrimaryButton(
            text: "Criar receita",
            icon: LineAwesomeIcons.alternate_pencil,
            onPressed: () => Navigator.pushNamed(context, Routes.createRecipe),
          ),
        ],
      ),
    );
  }
}
