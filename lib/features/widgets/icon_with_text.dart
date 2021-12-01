import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final TextStyle? textStyle;
  final double iconSize;

  const IconWithText({
    required this.icon,
    required this.color,
    required this.text,
    this.textStyle,
    this.iconSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: SizeConverter.fontSize(iconSize),
        ),
        Spacing(width: 4),
        Text(
          text,
          style: textStyle ?? AppTypo.a2(color: color),
        ),
      ],
    );
  }
}
