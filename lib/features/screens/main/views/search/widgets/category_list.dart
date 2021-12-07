import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/image_helper.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_page.dart';
import 'package:pratudo/features/widgets/app_default_error.dart';
import 'package:pratudo/features/widgets/conditional_widget.dart';
import 'package:pratudo/features/widgets/loading_shimmer.dart';

class CategoryList extends StatelessWidget {
  final List<RecipeHelperModel> categories;
  final bool isLoading;
  final bool hasError;
  final VoidCallback onTapError;

  const CategoryList({
    required this.categories,
    required this.isLoading,
    required this.onTapError,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return ConditionalWidget(
      isLoading: isLoading,
      hasError: hasError,
      errorWidget: AppDefaultError(
        onPressed: onTapError,
      ),
      loadingWidget: CategoryListShimmer(),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.only(
          top: SizeConverter.relativeHeight(16),
        ),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: SizeConverter.relativeWidth(24),
          mainAxisSpacing: SizeConverter.relativeWidth(16),
          mainAxisExtent: SizeConverter.relativeWidth(160),
        ),
        itemBuilder: (BuildContext context, int index) {
          RecipeHelperModel category = categories[index];
          return CategoryCard(
            category: category,
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.filteredIngredients,
                arguments: FilteredIngredientsPageParams(
                  SearchTypeEnum.CATEGORY,
                  category: category,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    this.categoryImage,
    required this.onTap,
  });

  final RecipeHelperModel category;
  final String? categoryImage;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackWith25Opacity,
              offset: Offset(0, 2),
              blurRadius: 10,
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(
              ImageHelper.convertBase64ToImage(category.image64!),
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            bottom: SizeConverter.relativeHeight(8),
          ),
          decoration: BoxDecoration(
            color: Color(0x990000000),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeConverter.relativeWidth(16),
                      ),
                      child: Text(
                        category.value,
                        style: AppTypo.p3(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 8,
        padding: EdgeInsets.only(
          top: SizeConverter.relativeHeight(16),
        ),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: SizeConverter.relativeWidth(24),
          mainAxisSpacing: SizeConverter.relativeWidth(16),
          mainAxisExtent: SizeConverter.relativeWidth(172),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
