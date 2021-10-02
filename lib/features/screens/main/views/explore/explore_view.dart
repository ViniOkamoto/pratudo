import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/enums/time_enum.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';
import 'package:pratudo/features/screens/main/widgets/carrousel_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
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
          Padding(
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
          ),
          Observer(
            builder: (context) {
              if (_exploreStore.isSearching) {
                if (_exploreStore.filteredRecipes.isEmpty && !_exploreStore.isLoadingSearch) return EmptyRecipe();
                if (_exploreStore.isLoadingSearch) {
                  return LoadingShimmer(
                    child: ListShimmer(),
                  );
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
              if (_exploreStore.isLoading)
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
                    LoadingShimmer(
                      child: CarrouselShimmer(),
                    ),
                  ],
                );
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
                      return CarrouselItem(
                        // isSelected: index == pageViewIndex,
                        recipe: recipe,
                      );
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
}

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
      ),
      physics: NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            top: SizeConverter.relativeHeight(index == 0 ? 0 : 16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConverter.relativeWidth(45),
                width: SizeConverter.relativeWidth(45),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGrayColor,
                ),
              ),
              Spacing(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConverter.relativeHeight(4),
                    ),
                    width: SizeConverter.relativeWidth(140),
                    height: SizeConverter.relativeWidth(8),
                    color: AppColors.lightGrayColor,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: SizeConverter.relativeHeight(4)),
                    width: SizeConverter.relativeWidth(100),
                    height: SizeConverter.relativeWidth(8),
                    color: AppColors.lightGrayColor,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmptyRecipe extends StatelessWidget {
  const EmptyRecipe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConverter.relativeWidth(16),
        vertical: SizeConverter.relativeHeight(16),
      ),
      child: Column(
        children: [
          Icon(
            LineAwesomeIcons.book,
            size: SizeConverter.fontSize(94),
            color: AppColors.highlightColor,
          ),
          Spacing(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Nenhuma receita encontrada.\n ',
              style: AppTypo.p3(color: AppColors.darkestColor),
              children: <TextSpan>[
                TextSpan(
                  text: 'O que acha de ',
                ),
                TextSpan(
                  text: 'compartilhar ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.highlightColor,
                  ),
                ),
                TextSpan(
                  text: 'alguma com a gente?',
                ),
              ],
            ),
          ),
          Spacing(height: 40),
          AppPrimaryButton(
            text: "Criar receita",
            icon: LineAwesomeIcons.alternate_pencil,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CarrouselItem extends StatefulWidget {
  const CarrouselItem({
    required this.recipe,
  });

  final SummaryRecipe recipe;

  @override
  _CarrouselItemState createState() => _CarrouselItemState();
}

class _CarrouselItemState extends State<CarrouselItem> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConverter.relativeWidth(20),
        horizontal: SizeConverter.relativeWidth(1),
      ),
      width: SizeConverter.relativeWidth(268),
      decoration: BoxDecoration(
        color: AppColors.lightestGrayColor,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(
            ImageHelper.convertBase64ToImage(widget.recipe.images.first),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConverter.relativeWidth(8),
                      vertical: SizeConverter.relativeHeight(8),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: AppColors.blueColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LineAwesomeIcons.clock,
                          size: SizeConverter.fontSize(16),
                          color: AppColors.whiteColor,
                        ),
                        Spacing(width: 4),
                        Text(
                          "${widget.recipe.preparationTime.value} ${convertEnumToShortTimeString(
                            widget.recipe.preparationTime.unit,
                          )}",
                          style: AppTypo.p5(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: SizeConverter.relativeHeight(60),
                      padding: EdgeInsets.only(
                        left: SizeConverter.relativeWidth(16),
                        right: SizeConverter.relativeWidth(8),
                        top: SizeConverter.relativeHeight(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(
                          0x660000000,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 7,
                                      child: Text(
                                        widget.recipe.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: AppTypo.h3(color: AppColors.whiteColor),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            LineAwesomeIcons.star_1,
                                            size: SizeConverter.fontSize(10),
                                            color: AppColors.yellowColor,
                                          ),
                                          Spacing(width: 4),
                                          Flexible(
                                            child: Text(
                                              "(${widget.recipe.rate})",
                                              style: AppTypo.p5(color: AppColors.yellowColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Feito por: ${widget.recipe.recipeOwner.name}",
                                  style: AppTypo.a2(color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
