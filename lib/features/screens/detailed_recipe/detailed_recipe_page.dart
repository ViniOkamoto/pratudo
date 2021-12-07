import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/comment_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/detailed_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/rate_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/chef_tip_section.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/comment_section.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/detailed_recipe_loading.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/ingredient_list.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/rate_modal.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_header.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_parameters.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/step_list.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/tag_category_list.dart';
import 'package:pratudo/features/screens/shared/step_by_step/step_by_step_model.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_default_error.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';
import 'package:pratudo/features/widgets/app_outline_button.dart';
import 'package:pratudo/features/widgets/app_primary_button.dart';
import 'package:pratudo/features/widgets/conditional_widget.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';
import 'package:pratudo/features/widgets/spacing.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailedRecipePage extends StatefulWidget {
  final String id;
  const DetailedRecipePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailedRecipePage> createState() => _DetailedRecipePageState();
}

class _DetailedRecipePageState extends State<DetailedRecipePage> {
  final DetailedRecipeStore store = serviceLocator<DetailedRecipeStore>();
  final RecipeHelpersStore helpersStore = serviceLocator<RecipeHelpersStore>();
  final RecipeRateStore rateStore = serviceLocator<RecipeRateStore>();
  final RecipeCommentStore commentStore = serviceLocator<RecipeCommentStore>();

  @override
  void initState() {
    initializePage();
    super.initState();
  }

  initializePage() async {
    await helpersStore.getUnitsOfMeasure();
    store.getRecipe(widget.id);
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
                    if (!store.isLoading && !store.hasError)
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
                    return Container();
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
                          return ConditionalWidget(
                            isLoading: store.isLoading,
                            loadingWidget: LoadingShimmer(
                              child: ShimmerBox(),
                            ),
                            hasError: store.hasError,
                            errorWidget: Container(
                              color: AppColors.lightestGrayColor,
                              child: Center(
                                child: Icon(
                                  LineAwesomeIcons.wifi,
                                  color: AppColors.highlightColor,
                                  size: SizeConverter.fontSize(80),
                                ),
                              ),
                            ),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: MemoryImage(kTransparentImage),
                              image: MemoryImage(
                                ImageHelper.convertBase64ToImage(
                                  store.detailedRecipeModel?.images.first ?? '',
                                ),
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
            if (store.isLoading) return DetailedRecipeLoading();
            if (store.hasError)
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConverter.relativeWidth(16),
                ),
                child: AppDefaultError(
                  onPressed: () => store.getRecipe(widget.id),
                ),
              );
            DetailedRecipeModel recipe = store.detailedRecipeModel!;
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
                          comments: recipe.comments.length,
                          preparations: recipe.preparations,
                        ),
                        Spacing(height: 24),
                        RecipeParameters(
                          time: recipe.totalMethodOfPreparationTime,
                          difficulty: recipe.difficulty,
                          totalIngredients: recipe.totalIngredients,
                        ),
                        Spacing(height: 16),
                        if (recipe.isUserAllowedToRate) ...[
                          AppOutlinedButton(
                            onPressed: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (context) => RateModal(
                                  recipeName: recipe.name,
                                  recipeId: recipe.id,
                                ),
                              ) as bool?;
                              if (result ?? false) {
                                store.getRecipe(store.detailedRecipeModel!.id);
                              }
                            },
                            text: 'Ja fiz essa receita',
                          ),
                          Spacing(height: 16),
                        ],
                        AppPrimaryButton(
                          text: 'Modo passo a passo',
                          icon: LineAwesomeIcons.mortar_pestle,
                          onPressed: () => _detailedRecipe(),
                        ),
                        Spacing(height: 16),
                        IngredientsListSection(
                          ingredients: recipe.ingredients,
                          unitsOfMeasure: helpersStore.units,
                        ),
                        Spacing(height: 24),
                        StepListSection(
                          steps: recipe.methodOfPreparation.steps,
                        ),
                        Spacing(height: 24),
                        ChefTipSection(text: recipe.chefTips),
                        Spacing(height: 32),
                        CommentsSection(
                          comments: recipe.comments,
                        )
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

  _detailedRecipe() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.stepByStep,
      arguments: StepByStepModel(
        recipeId: store.detailedRecipeModel!.id,
        name: store.detailedRecipeModel!.name,
        chefTips: store.detailedRecipeModel!.chefTips,
        ingredients: store.detailedRecipeModel!.ingredients,
        steps: store.detailedRecipeModel!.methodOfPreparation.steps,
        userIsAllowedToRate: store.detailedRecipeModel!.isUserAllowedToRate,
      ),
    ) as bool?;
    if (result ?? false) {
      store.getRecipe(store.detailedRecipeModel!.id);
    }
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
