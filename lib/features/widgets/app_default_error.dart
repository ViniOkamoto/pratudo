import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class AppDefaultError extends StatelessWidget {
  const AppDefaultError({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
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
            LineAwesomeIcons.mug_hot,
            size: SizeConverter.fontSize(94),
            color: AppColors.highlightColor,
          ),
          Spacing(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Algo aconteceu de forma ',
              style: AppTypo.p3(color: AppColors.darkestColor),
              children: <TextSpan>[
                TextSpan(
                  text: 'inesperada\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'Tome um ',
                ),
                TextSpan(
                  text: 'cafezinho ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'e tente novamente.',
                ),
              ],
            ),
          ),
          Spacing(height: 40),
          AppPrimaryButton(
            text: "Tentar novamente",
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
