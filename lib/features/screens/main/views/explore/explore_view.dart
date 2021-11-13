import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/carousel_item.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/carousel_shimmer.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/filter_row.dart';
import 'package:pratudo/features/screens/main/widgets/base_page.dart';
import 'package:pratudo/features/screens/main/widgets/search_section.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/app_default_error.dart';
import 'package:pratudo/features/widgets/conditional_widget.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> with AutomaticKeepAliveClientMixin {
  final ExploreStore _exploreStore = serviceLocator<ExploreStore>();
  final RecipeHelpersStore _recipeHelpersStore = serviceLocator<RecipeHelpersStore>();
  final SearchStore _searchStore = serviceLocator<SearchStore>();

  @override
  void initState() {
    _fetchInitialData();
    super.initState();
  }

  _fetchInitialData() async {
    await _recipeHelpersStore.getFilters();
    if (_recipeHelpersStore.filters.isNotEmpty) {
      _exploreStore.getLatestRecipe(_recipeHelpersStore.filters.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onRefresh: () => _fetchInitialData(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConverter.relativeWidth(16),
            ),
            child: Text(
              "O que vamos cozinhar hoje?",
              style: AppTypo.h2(color: AppColors.darkestColor),
            ),
          ),
          Spacing(height: 16),
          SearchSection(
            searchStore: _searchStore,
            pageContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(
                  builder: (context) {
                    return ConditionalWidget(
                      isLoading: _recipeHelpersStore.isLoadingFilters,
                      loadingWidget: CarouselShimmer(),
                      hasError: _recipeHelpersStore.hasErrorInFilters && _exploreStore.recipes.isEmpty,
                      errorWidget: AppDefaultError(
                        onPressed: () => _fetchInitialData(),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FilterRow(
                            recipeHelpersStore: _recipeHelpersStore,
                            onPressedFilter: _exploreStore.getLatestRecipe,
                            filterSelected: _exploreStore.filterSelected,
                          ),
                          ConditionalWidget(
                            isLoading: _exploreStore.isLoading && !_recipeHelpersStore.isLoadingFilters,
                            loadingWidget: CarouselShimmer(withoutFilterRow: true),
                            hasError: _exploreStore.hasError,
                            errorWidget: AppDefaultError(
                              onPressed: () => _exploreStore.getLatestRecipe(_exploreStore.filterSelected!),
                            ),
                            child: Column(
                              children: [
                                Spacing(height: 8),
                                CarouselSlider.builder(
                                  key: UniqueKey(),
                                  itemCount: _exploreStore.recipes.length,
                                  options: CarouselOptions(
                                    viewportFraction: 0.6,
                                    enableInfiniteScroll: true,
                                    height: SizeConverter.relativeHeight(300),
                                    enlargeCenterPage: true,
                                    scrollPhysics: BouncingScrollPhysics(),
                                    onPageChanged: (index, _) {
                                      _exploreStore.currentIndex = index;
                                    },
                                  ),
                                  itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                                    SummaryRecipe recipe = _exploreStore.recipes[index];
                                    return CarouselItem(recipe: recipe);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
