import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class AppIconButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color? buttonColor;
  final Color borderColor;
  final double buttonRadius;
  final VoidCallback onTap;

  const AppIconButton({
    this.iconData = LineAwesomeIcons.arrow_left,
    this.iconSize = 20,
    this.iconColor = AppColors.highlightColor,
    this.buttonColor,
    this.borderColor = AppColors.highlightColor,
    this.buttonRadius = 5,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.lightestHighlightColor,
      borderRadius: BorderRadius.circular(buttonRadius),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Icon(
          iconData,
          size: SizeConverter.fontSize(iconSize),
          color: iconColor,
        ),
      ),
    );
  }
}
