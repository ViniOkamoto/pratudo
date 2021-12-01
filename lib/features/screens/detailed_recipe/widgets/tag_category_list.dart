import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class TagCategoryList extends StatelessWidget {
  final List<String> categories;

  const TagCategoryList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String category = categories[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConverter.relativeWidth(8),
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    category,
                    style: AppTypo.p3(
                      color: AppColors.whiteColor,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Spacing(width: 8),
              itemCount: categories.length,
            ),
          ),
        ),
      ],
    );
  }
}
