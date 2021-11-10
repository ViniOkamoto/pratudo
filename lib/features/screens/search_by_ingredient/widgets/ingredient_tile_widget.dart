import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';

class IngredientTileWidget extends StatelessWidget {
  final String ingredient;
  final Function(int) onTapDelete;
  final int index;

  IngredientTileWidget({
    required this.ingredient,
    required this.onTapDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConverter.relativeHeight(12),
        bottom: SizeConverter.relativeHeight(12),
        left: SizeConverter.relativeWidth(16),
        right: SizeConverter.relativeWidth(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWith25Opacity,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ingredient,
            style: AppTypo.p3(color: AppColors.darkerColor),
          ),
          InkWell(
            onTap: () => onTapDelete(index),
            child: Icon(
              LineAwesomeIcons.alternate_trash,
              size: SizeConverter.fontSize(26),
              color: AppColors.lightGrayColor,
            ),
          )
        ],
      ),
    );
  }
}
