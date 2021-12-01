import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/models/recipe/ingredient_model.dart';
import 'package:pratudo/features/models/recipe/items_model.dart';
import 'package:pratudo/features/models/unit_model.dart';
import 'package:pratudo/features/screens/detailed_recipe/detailed_recipe_store.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/detailed_recipe_loading.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_header.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/recipe_parameters.dart';
import 'package:pratudo/features/screens/detailed_recipe/widgets/tag_category_list.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/widgets/app_default_error.dart';
import 'package:pratudo/features/widgets/app_icon_button.dart';
import 'package:pratudo/features/widgets/app_outline_button.dart';
import 'package:pratudo/features/widgets/conditional_widget.dart';
import 'package:pratudo/features/widgets/custom_text.dart';
import 'package:pratudo/features/widgets/icon_with_text.dart';
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
  @override
  void initState() {
    store.getRecipe(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            Observer(
              builder: (context) {
                return SliverAppBar(
                  expandedHeight: SizeConverter.relativeHeight(200),
                  backgroundColor: AppColors.whiteColor,
                  floating: true,
                  pinned: true,
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
                    if (!store.isLoading && !store.hasError)
                      Row(
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
                              onTap: () {},
                              iconData: LineAwesomeIcons.bookmark,
                            ),
                          ),
                          Spacing(width: 16),
                        ],
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
                        StreamBuilder<Object>(
                            stream: null,
                            builder: (context, snapshot) {
                              return Positioned.fill(
                                child: ConditionalWidget(
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
                                        store.detailedRecipeModel?.images
                                                .first ??
                                            '',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              },
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
              padding: EdgeInsets.symmetric(
                horizontal: SizeConverter.relativeWidth(16),
                vertical: SizeConverter.relativeWidth(16),
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
                          detailedRecipeModel: recipe,
                        ),
                        Spacing(height: 24),
                        RecipeParameters(
                          detailedRecipeModel: recipe,
                        ),
                        Spacing(height: 16),
                        if (recipe.isUserAllowedToRate) ...[
                          AppOutlinedButton(
                            onPressed: () {},
                            text: 'Ja fiz essa receita',
                          ),
                          Spacing(height: 16),
                        ],
                        IngredientsList(
                          ingredients: recipe.ingredients,
                          unitsOfMeasure: helpersStore.units,
                        ),
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

class IngredientsList extends StatelessWidget {
  const IngredientsList({
    Key? key,
    required this.ingredients,
    required this.unitsOfMeasure,
  }) : super(key: key);
  final List<IngredientModel> ingredients;
  final List<UnitModel> unitsOfMeasure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconWithText(
          icon: LineAwesomeIcons.blender,
          color: AppColors.darkerColor,
          text: 'Ingredientes',
          textStyle: AppTypo.h2(color: AppColors.darkerColor),
          iconSize: 26,
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(8),
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            IngredientModel ingredient = ingredients[index];
            return StepItems(
              stepName: ingredient.step!,
              items: ingredient.items ?? [],
              unitsOfMeasure: unitsOfMeasure,
            );
          },
          separatorBuilder: (context, index) => Spacing(height: 16),
          itemCount: ingredients.length,
        ),
      ],
    );
  }
}

class StepItems extends StatelessWidget {
  const StepItems({
    Key? key,
    required this.stepName,
    required this.items,
    required this.unitsOfMeasure,
  }) : super(key: key);

  final String stepName;
  final List<ItemsModel> items;
  final List<UnitModel> unitsOfMeasure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConverter.relativeHeight(8),
          ),
          child: Text(
            stepName,
            style: AppTypo.p3(color: AppColors.darkestColor),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            ItemsModel item = items[index];
            UnitModel unit = unitsOfMeasure.firstWhere(
                (element) => element.key == item.portion.unitOfMeasure);
            return Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    color: AppColors.orangeColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacing(width: 8),
                CustomText(
                  text:
                      '*${item.portion.quantity} ${unit.translate} de* ${item.name}',
                  style: AppTypo.p3(color: AppColors.darkColor),
                  highlightTextColor: AppColors.darkerColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            );
          },
          itemCount: items.length,
          separatorBuilder: (context, index) => Spacing(height: 8),
        ),
      ],
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
