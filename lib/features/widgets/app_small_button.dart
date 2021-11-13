import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppSmallButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double height;
  final Color buttonColor;
  final Color borderColor;
  final Color inactiveBorderColor;
  final Color textColor;

  const AppSmallButton({
    this.onPressed,
    required this.text,
    this.height = 32,
    this.buttonColor = AppColors.highlightColor,
    this.borderColor = AppColors.highlightColor,
    this.textColor = AppColors.whiteColor,
    this.inactiveBorderColor = AppColors.lightestHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConverter.relativeWidth(height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: onPressed != null ? borderColor : inactiveBorderColor,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Text(
          text,
          style: AppTypo.p4(color: textColor),
        ),
      ),
    );
  }
}
