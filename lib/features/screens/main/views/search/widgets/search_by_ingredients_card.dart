import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchByIngredientsCard extends StatelessWidget {
  const SearchByIngredientsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConverter.relativeHeight(16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWith25Opacity,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: SizeConverter.relativeHeight(8),
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LineAwesomeIcons.book,
            size: SizeConverter.fontSize(32),
            color: AppColors.highlightColor,
          ),
          Spacing(width: 16),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Experimente encontrar receitas baseadas nos ingredientes que você tem em casa',
                  style: AppTypo.p3(color: AppColors.darkColor),
                ),
                Spacing(height: 8),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.searchByIngredient),
                  child: Container(
                    height: SizeConverter.relativeWidth(16),
                    child: Row(
                      children: [
                        Text(
                          'Vamos tentar',
                          style: AppTypo.p4(
                            color: AppColors.highlightColor,
                          ),
                        ),
                        Icon(
                          LineAwesomeIcons.arrow_right,
                          color: AppColors.highlightColor,
                          size: SizeConverter.fontSize(16),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
