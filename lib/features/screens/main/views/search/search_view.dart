import 'package:flutter/material.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/category_list.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/search_by_ingredients_card.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';

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
          CategoryList()
        ],
      ),
    );
  }
}
