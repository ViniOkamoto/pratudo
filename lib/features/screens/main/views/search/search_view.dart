import 'package:flutter/material.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/category_list.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/search_by_ingredients_card.dart';
import 'package:pratudo/features/screens/main/widgets/search_section.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';

class SearchView extends StatelessWidget {
  final SearchStore _searchStore = serviceLocator<SearchStore>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: SizeConverter.relativeHeight(16),
      ),
      physics: BouncingScrollPhysics(),
      child: SearchSection(
        searchStore: _searchStore,
        pageContent: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchByIngredientsCard(),
              Text(
                'Categorias',
                style: AppTypo.p2(color: AppColors.darkColor),
              ),
              CategoryList()
            ],
          ),
        ),
      ),
    );
  }
}
