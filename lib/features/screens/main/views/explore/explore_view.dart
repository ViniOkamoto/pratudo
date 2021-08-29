import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/summary_recipe.dart';
import 'package:pratudo/features/screens/main/views/explore/explore_store.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
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
                  textEditingController: TextEditingController(),
                  onChanged: (onChanged) {},
                ),
                Spacing(height: 24),
                Text(
                  "Últimas receitas",
                  style: AppTypo.p2(color: AppColors.darkColor),
                ),
                Spacing(height: 8),
              ],
            ),
          ),
          Observer(
            builder: (context) {
              if (_exploreStore.isLoading) return LoadingShimmer();
              return CarouselSlider.builder(
                key: UniqueKey(),
                itemCount: _exploreStore.recipes.length,
                options: CarouselOptions(
                  viewportFraction: 0.6,
                  enableInfiniteScroll: true,
                  pageViewKey: PageStorageKey("key"),
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
              );
            },
          ),
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
          BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    // Expanded(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(15),
                    //     child: FadeInImage(
                    //       fit: BoxFit.cover,
                    //       placeholder: MemoryImage(
                    //         kTransparentImage,
                    //       ),
                    //       image: MemoryImage(
                    //         ImageHelper.convertBase64ToImage(widget.recipe.images.first),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: SizeConverter.relativeHeight(60),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConverter.relativeWidth(16),
                        vertical: SizeConverter.relativeHeight(8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(
                          0x330000000,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.recipe.name,
                                  style: AppTypo.h3(color: AppColors.whiteColor),
                                ),
                                Text(
                                  "Feito por: ${widget.recipe.recipeOwner.name}",
                                  style: AppTypo.a2(color: AppColors.whiteColor),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: widget.recipe.rate == 0,
                                        child: Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _getInt(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              if (index + 1 == _getInt() && _getIsRounded())
                                                return Icon(
                                                  LineAwesomeIcons.star_half_1,
                                                  size: SizeConverter.fontSize(10),
                                                  color: Color(0xFFFFE03B),
                                                );
                                              return Icon(
                                                LineAwesomeIcons.star_1,
                                                size: SizeConverter.fontSize(10),
                                                color: Color(0xFFFFE03B),
                                              );
                                            },
                                          ),
                                        ),
                                        replacement: Text(
                                          "Sem avaliações",
                                          style: AppTypo.a2(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
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

  int _getInt() {
    return widget.recipe.rate.round();
  }

  bool _getIsRounded() {
    double decimal = widget.recipe.rate % widget.recipe.rate.truncate();
    return decimal >= 0.5 && decimal < 1;
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConverter.relativeHeight(16),
      ),
      child: Shimmer.fromColors(
        enabled: true,
        highlightColor: AppColors.lightestGrayColor,
        baseColor: AppColors.lightGrayColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: SizeConverter.relativeWidth(316),
                    child: _LoadingCard(
                      width: 223,
                      height: 200,
                    ),
                  ),
                  Positioned(
                    left: SizeConverter.relativeWidth(316),
                    child: _LoadingCard(
                      width: 223,
                      height: 200,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _LoadingCard(
                      width: 223,
                      height: 269,
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

class _LoadingCard extends StatelessWidget {
  final double height;
  final double width;

  const _LoadingCard({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConverter.relativeHeight(height),
      width: SizeConverter.relativeWidth(width),
      decoration: BoxDecoration(
        color: AppColors.highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
