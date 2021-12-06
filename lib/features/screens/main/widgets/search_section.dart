import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/theme/typography.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/difficulty_enum.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/multi_select_form_field.dart';
import 'package:pratudo/features/screens/create_recipe/widgets/portions_field.dart';
import 'package:pratudo/features/screens/main/widgets/empty_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/list_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/app_small_button.dart';
import 'package:pratudo/features/widgets/base_modal.dart';
import 'package:pratudo/features/widgets/custom_multi_select_bottom_sheet/custom_multi_select_item.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    Key? key,
    required SearchStore searchStore,
    required this.pageContent,
  })  : _searchStore = searchStore,
        super(key: key);

  final SearchStore _searchStore;
  final Widget pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConverter.relativeWidth(16),
          ),
          child: AppSearchField(
            hintText: "Digite o nome da receita",
            textEditingController: _searchStore.searchController,
            onChanged: _searchStore.setSearchText,
            onSubmitted: (value) => _searchStore.getRecipeByText(),
          ),
        ),
        RecipeSearchResult(
          searchStore: _searchStore,
          pageContent: pageContent,
        ),
      ],
    );
  }
}

class RecipeSearchResult extends StatelessWidget {
  RecipeSearchResult({
    Key? key,
    required SearchStore searchStore,
    this.recipeType,
    this.pageContent,
  })  : _searchStore = searchStore,
        super(key: key);

  final RecipeHelpersStore helpersStore = serviceLocator<RecipeHelpersStore>();
  final FilteredIngredientsEnum? recipeType;
  final SearchStore _searchStore;
  final Widget? pageContent;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_searchStore.isSearching || pageContent == null) {
          if (_searchStore.isEmptyRecipe) return EmptyRecipe();
          if (_searchStore.isLoadingSearch ||
              helpersStore.isLoadingCategories) {
            return ListShimmer();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing(height: 16),
              SizedBox(
                height: 25,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          left: SizeConverter.relativeWidth(16),
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return FilterButton(
                              onPressed: () {
                                _showAddFilter(context);
                              },
                              icon: LineAwesomeIcons.plus,
                              text: 'Adicionar filtro',
                              buttonColor: AppColors.whiteColor,
                              textColor: AppColors.darkColor,
                            );
                          }
                          return Container();
                        },
                        itemCount: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Spacing(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _searchStore.filteredRecipes.length,
                itemBuilder: (context, index) {
                  SummaryRecipe recipe = _searchStore.filteredRecipes[index];
                  return RecipeTile(
                    recipe: recipe,
                    recipeType: recipeType,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Spacing(height: 16);
                },
              ),
            ],
          );
        }
        return pageContent ?? Container();
      },
    );
  }

  _showAddFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BaseModal(
        title: 'Filtros',
        height: 500,
        body: Expanded(
          child: Scrollbar(
            child: ListView(
              padding: EdgeInsets.only(
                bottom: SizeConverter.relativeHeight(24),
              ),
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          MultiSelectFormField<RecipeHelperModel>(
                            label: 'Filtros de categoria',
                            onConfirm: (values) {},
                            builderElement: helpersStore.categories
                                .map((e) => CustomMultiSelectItem(
                                      label: e.value,
                                      value: e,
                                    ))
                                .toList(),
                            itemsList: helpersStore.categories,
                            onTapChipSelected: (value) {},
                            selectedItems: [],
                            hintText: 'Selecione as categorias',
                            bottomSheetTitle: 'Categorias de comida',
                          ),
                          Spacing(height: 16),
                          MultiSelectFormField<DifficultyEnum>(
                            label: 'Filtros de dificuldade',
                            onConfirm: (values) {},
                            builderElement: difficultyList
                                .map(
                                  (e) => CustomMultiSelectItem(
                                    label: e.label,
                                    value: e,
                                  ),
                                )
                                .toList(),
                            itemsList: difficultyList,
                            onTapChipSelected: (value) {},
                            selectedItems: [],
                            hintText: 'Selecione dificuldades',
                            bottomSheetTitle: 'Dificuldades de receita',
                          ),
                          Spacing(height: 16),
                          PortionsField(
                            onTapLess: () {},
                            onTapMore: () {},
                            portionValue: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottom: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConverter.relativeHeight(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppSmallButton(
                text: 'Cancelar',
                onPressed: () {},
                borderColor: AppColors.greyColor,
                buttonColor: AppColors.greyColor,
                textColor: AppColors.whiteColor,
              ),
              Spacing(width: 16),
              AppSmallButton(
                text: 'Filtrar receitas',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color buttonColor;
  final Color borderColor;
  final Color inactiveBorderColor;
  final Color textColor;
  final IconData? icon;

  const FilterButton({
    this.onPressed,
    this.icon,
    required this.text,
    this.buttonColor = AppColors.darkColor,
    this.borderColor = AppColors.darkColor,
    this.textColor = AppColors.darkColor,
    this.inactiveBorderColor = AppColors.lightestHighlightColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConverter.relativeWidth(8),
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.symmetric(
            horizontal: BorderSide(
              color: borderColor,
            ),
            vertical: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: AppTypo.p5(color: textColor),
            ),
            if (icon != null) ...[
              Spacing(width: 8),
              Icon(
                icon!,
                size: SizeConverter.fontSize(8),
                color: textColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
