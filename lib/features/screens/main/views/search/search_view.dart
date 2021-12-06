import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/category_list.dart';
import 'package:pratudo/features/screens/main/views/search/widgets/search_by_ingredients_card.dart';
import 'package:pratudo/features/screens/main/widgets/base_page.dart';
import 'package:pratudo/features/screens/main/widgets/search_section.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchStore _searchStore = serviceLocator<SearchStore>();
  final RecipeHelpersStore _recipeHelpersStore =
      serviceLocator<RecipeHelpersStore>();

  _fetchData({bool isRefreshing = false}) async {
    if (isRefreshing) _searchStore.clearSearch();
    await _recipeHelpersStore.getCategories(fetchingNewData: isRefreshing);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onRefresh: () => _fetchData(isRefreshing: true),
      child: SearchSection(
        searchStore: _searchStore,
        pageContent: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing(height: 24),
              SearchByIngredientsCard(),
              Text(
                'Categorias',
                style: AppTypo.p2(color: AppColors.darkColor),
              ),
              Observer(builder: (context) {
                return CategoryList(
                  categories: _recipeHelpersStore.categories,
                  isLoading: _recipeHelpersStore.isLoadingCategories,
                  hasError: _recipeHelpersStore.hasErrorInCategories,
                  onTapError: () => _recipeHelpersStore.getCategories(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
