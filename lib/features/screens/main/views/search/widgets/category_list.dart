import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/image_string.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 8,
      padding: EdgeInsets.only(
        top: SizeConverter.relativeHeight(16),
      ),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: SizeConverter.relativeWidth(24),
        mainAxisSpacing: SizeConverter.relativeWidth(16),
        mainAxisExtent: SizeConverter.relativeWidth(172),
      ),
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard();
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    this.category,
    this.categoryImage,
  }) : super(key: key);
  final String? category;
  final String? categoryImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackWith25Opacity,
            offset: Offset(0, 2),
            blurRadius: 10,
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(
            ImageHelper.convertBase64ToImage(imageTest),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          bottom: SizeConverter.relativeHeight(8),
        ),
        decoration: BoxDecoration(
          color: Color(0x660000000),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lorem Ipsum',
                    style: AppTypo.h3(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
