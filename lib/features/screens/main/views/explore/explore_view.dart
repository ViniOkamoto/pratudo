import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/carousel_item.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/carousel_shimmer.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/empty_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/list_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    _exploreStore.getLatestRecipe();
    super.initState();
  }

  final ExploreStore _exploreStore = serviceLocator<ExploreStore>();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchSection(
            searchController: _searchController,
            exploreStore: _exploreStore,
          ),
          Observer(
            builder: (context) {
              if (_exploreStore.isSearching) {
                if (_exploreStore.filteredRecipes.isEmpty && !_exploreStore.isLoadingSearch) return EmptyRecipe();
                if (_exploreStore.isLoadingSearch) {
                  return ListShimmer();
                }
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _exploreStore.filteredRecipes.length,
                      itemBuilder: (context, index) {
                        SummaryRecipe recipe = _exploreStore.filteredRecipes[index];
                        return RecipeTile(
                          recipe: recipe,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Spacing(height: index == 0 ? 0 : 16);
                      },
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConverter.relativeWidth(16),
                    ),
                    child: Text(
                      "Últimas receitas",
                      style: AppTypo.p2(color: AppColors.darkColor),
                    ),
                  ),
                  Visibility(
                    visible: _exploreStore.isLoading,
                    child: LoadingShimmer(
                      child: CarouselShimmer(),
                    ),
                    replacement: Column(
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
                            return CarouselItem(
                              recipe: recipe,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection({
    Key? key,
    required TextEditingController searchController,
    required ExploreStore exploreStore,
  })  : _searchController = searchController,
        _exploreStore = exploreStore,
        super(key: key);

  final TextEditingController _searchController;
  final ExploreStore _exploreStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing(height: 24),
          Text(
            "O que vamos cozinhar hoje?",
            style: AppTypo.h2(color: AppColors.darkestColor),
          ),
          Spacing(height: 16),
          AppSearchField(
            hintText: "Digite o nome da receita",
            textEditingController: _searchController,
            onChanged: _exploreStore.setSearchText,
            onSubmitted: (value) => _exploreStore.getFilteredRecipes(),
          ),
          Spacing(height: 24),
        ],
      ),
    );
  }
}
