import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConverter.relativeHeight(16),
      ),
      padding: EdgeInsets.symmetric(
        vertical: SizeConverter.relativeHeight(14),
        horizontal: SizeConverter.relativeWidth(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWith25Opacity,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTypo.p2(color: AppColors.darkColor),
            ),
            Icon(
              icon,
              color: AppColors.lightGrayColor,
              size: SizeConverter.fontSize(30),
            ),
          ],
        ),
      ),
    );
  }
}
