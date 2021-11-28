import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppSecondaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double height;

  const AppSecondaryButton({
    this.onPressed,
    required this.text,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: SizeConverter.relativeWidth(height),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: AppColors.greyColor,
              ),
              child: Text(
                text,
                style: AppTypo.buttonText(color: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
