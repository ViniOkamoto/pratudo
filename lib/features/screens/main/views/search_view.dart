import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:pratudo/image_string.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConverter.relativeWidth(16), vertical: SizeConverter.relativeHeight(16)),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSearchField(
            hintText: 'Digite o nome da receita',
            textEditingController: TextEditingController(),
            onChanged: (onChanged) {},
          ),
          SearchByIngredientsCard(),
          Text(
            'Categorias',
            style: AppTypo.p2(color: AppColors.darkColor),
          ),
          GridView.builder(
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
          )
        ],
      ),
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

class SearchByIngredientsCard extends StatelessWidget {
  const SearchByIngredientsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConverter.relativeHeight(16),
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
                  onTap: () {},
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
