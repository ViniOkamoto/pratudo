import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/screens/cached_recipe/detailed_cache_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/chef_tip_section.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/ingredient_list.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_header.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_parameters.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/step_list.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/tag_category_list.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailedCacheRecipePage extends StatefulWidget {
  final CacheRecipeModel recipe;
  const DetailedCacheRecipePage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<DetailedCacheRecipePage> createState() =>
      _DetailedCacheRecipePageState();
}

class _DetailedCacheRecipePageState extends State<DetailedCacheRecipePage> {
  final DetailedCacheRecipeStore store =
      serviceLocator<DetailedCacheRecipeStore>();
  final RecipeHelpersStore helpersStore = serviceLocator<RecipeHelpersStore>();

  @override
  void initState() {
    initializePage();
    super.initState();
  }

  initializePage() async {
    store.recipeModel = widget.recipe;
    await helpersStore.getUnitsOfMeasure();
    await store.checkIfRecipeIsCached();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: SizeConverter.relativeHeight(200),
              backgroundColor: AppColors.whiteColor,
              floating: true,
              pinned: false,
              snap: true,
              collapsedHeight: SizeConverter.relativeHeight(50),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              leading: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConverter.relativeWidth(16),
                  ),
                  child: _AppBarAction(
                    onTap: () => Navigator.pop(context),
                    iconData: LineAwesomeIcons.arrow_left,
                  ),
                ),
              ),
              actions: [
                Observer(
                  builder: (context) {
                    return Row(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: _AppBarAction(
                            onTap: () {},
                            iconData: LineAwesomeIcons.share,
                          ),
                        ),
                        Spacing(width: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _AppBarAction(
                            onTap: () {
                              store.isCachedRecipe
                                  ? store.removeCachedRecipe()
                                  : store.cacheRecipe();
                            },
                            iconData: store.isCachedRecipe
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                        ),
                        Spacing(width: 16),
                      ],
                    );
                  },
                ),
              ],
              flexibleSpace: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15.0),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Observer(
                        builder: (context) {
                          return FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: MemoryImage(kTransparentImage),
                            image: MemoryImage(
                              ImageHelper.convertBase64ToImage(
                                store.recipeModel?.images.first ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Observer(
          builder: (context) {
            CacheRecipeModel recipe = store.recipeModel!;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: SizeConverter.relativeWidth(16),
                right: SizeConverter.relativeWidth(16),
                top: SizeConverter.relativeWidth(16),
                bottom: SizeConverter.relativeWidth(120),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TagCategoryList(
                          categories: recipe.categories,
                        ),
                        Spacing(height: 8),
                        RecipeHeader(
                          portions: recipe.portions,
                          name: recipe.name,
                          rate: recipe.rate,
                          ownerName: recipe.owner.name,
                        ),
                        Spacing(height: 24),
                        RecipeParameters(
                          time: recipe.totalMethodOfPreparationTime,
                          difficulty: recipe.difficulty,
                          totalIngredients: recipe.totalIngredients,
                        ),
                        Spacing(height: 16),
                        AppPrimaryButton(
                          text: 'Modo passo a passo',
                          icon: LineAwesomeIcons.mortar_pestle,
                          onPressed: () {},
                        ),
                        Spacing(height: 16),
                        IngredientsListSection(
                          ingredients: recipe.ingredients,
                          unitsOfMeasure: helpersStore.units,
                        ),
                        Spacing(height: 24),
                        StepListSection(
                            steps: recipe.methodOfPreparation.steps),
                        Spacing(height: 24),
                        ChefTipSection(text: recipe.chefTips),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AppBarAction extends StatelessWidget {
  const _AppBarAction({
    Key? key,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onTap: onTap,
      iconData: iconData,
      buttonColor: AppColors.whiteColor,
    );
  }
}
