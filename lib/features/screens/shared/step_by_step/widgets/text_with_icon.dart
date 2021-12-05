import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class TextWithIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Color color;
  final bool iconIsLeading;

  const TextWithIcon({
    Key? key,
    this.color = AppColors.darkHighlightColor,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconIsLeading = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 20,
        child: Row(
          children: [
            if (iconIsLeading)
              Icon(
                icon,
                size: SizeConverter.fontSize(12),
                color: color,
              ),
            Text(
              title,
              style: AppTypo.p5(color: color),
            ),
            if (!iconIsLeading)
              Icon(
                icon,
                size: SizeConverter.fontSize(12),
                color: color,
              ),
          ],
        ),
      ),
    );
  }
}
