import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/items_model.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class IngredientItems extends StatelessWidget {
  const IngredientItems({
    Key? key,
    required this.stepName,
    required this.items,
    required this.unitsOfMeasure,
  }) : super(key: key);

  final String stepName;
  final List<ItemsModel> items;
  final List<UnitModel> unitsOfMeasure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConverter.relativeHeight(8),
          ),
          child: Text(
            stepName,
            style: AppTypo.p3(color: AppColors.darkestColor),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ItemsModel item = items[index];
            UnitModel unit = unitsOfMeasure.firstWhere(
                (element) => element.key == item.portion.unitOfMeasure);
            return Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: AppColors.orangeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacing(width: 8),
                CustomText(
                  text:
                      '*${item.portion.quantity} ${unit.translate.toLowerCase()} de* ${item.name}',
                  style: AppTypo.p3(color: AppColors.darkColor),
                  highlightTextColor: AppColors.darkerColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            );
          },
          itemCount: items.length,
          separatorBuilder: (context, index) => Spacing(height: 8),
        ),
      ],
    );
  }
}
