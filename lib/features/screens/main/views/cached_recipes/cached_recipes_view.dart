import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/screens/main/views/cached_recipes/widgets/cached_carousel_item.dart';
import 'package:pratudo/features/screens/main/views/explore/widgets/carousel_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/base_page.dart';
import 'package:pratudo/features/widgets/app_default_error.dart';
import 'package:pratudo/features/widgets/spacing.dart';

import 'cached_recipes_store.dart';

class CachedRecipesView extends StatefulWidget {
  const CachedRecipesView({Key? key}) : super(key: key);

  @override
  _CachedRecipesViewState createState() => _CachedRecipesViewState();
}

class _CachedRecipesViewState extends State<CachedRecipesView>
    with AutomaticKeepAliveClientMixin {
  final CachedRecipesStore cachedRecipesStore =
      serviceLocator<CachedRecipesStore>();
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    await cachedRecipesStore.getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onRefresh: () => _fetchData(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConverter.relativeWidth(16),
            ),
            child: Text(
              "Receitas salvas",
              style: AppTypo.p2(color: AppColors.darkestColor),
            ),
          ),
          Spacing(height: 16),
          Observer(
            builder: (context) {
              if (cachedRecipesStore.isLoading)
                return CarouselShimmer(withoutFilterRow: true);
              if (cachedRecipesStore.hasError)
                return AppDefaultError(
                  onPressed: () => _fetchData(),
                );
              if (cachedRecipesStore.recipes.isEmpty) {
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacing(height: 100),
                          Icon(
                            LineAwesomeIcons.book_reader,
                            color: AppColors.highlightColor,
                            size: SizeConverter.fontSize(120),
                          ),
                          Text(
                            'Nenhuma receita salva',
                            style: AppTypo.p3(color: AppColors.darkestColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                        '${cachedRecipesStore.currentIndex + 1} de ${cachedRecipesStore.recipes.length} Receitas '),
                  ),
                  Spacing(height: 8),
                  CarouselSlider.builder(
                    key: ValueKey(Key('teste')),
                    itemCount: cachedRecipesStore.recipes.length,
                    options: CarouselOptions(
                      viewportFraction: 0.6,
                      enableInfiniteScroll: true,
                      height: SizeConverter.relativeHeight(300),
                      enlargeCenterPage: true,
                      scrollPhysics: BouncingScrollPhysics(),
                      onPageChanged: (index, _) {
                        cachedRecipesStore.currentIndex = index;
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) {
                      CacheRecipeModel recipe =
                          cachedRecipesStore.recipes[index];
                      return CachedCarouselItem(recipe: recipe);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
