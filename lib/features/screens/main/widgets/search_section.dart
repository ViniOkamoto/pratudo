import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/core/theme/colors.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/empty_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/filter_modal/filter_modal.dart';
import 'package:pratudo/features/screens/main/widgets/list_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/recipe_helpers_store.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    Key? key,
    required SearchStore searchStore,
    required this.pageContent,
    required this.searchTypeEnum,
  })  : _searchStore = searchStore,
        super(key: key);

  final SearchStore _searchStore;
  final SearchTypeEnum searchTypeEnum;
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
          searchType: searchTypeEnum,
        ),
      ],
    );
  }
}

class RecipeSearchResult extends StatefulWidget {
  RecipeSearchResult({
    Key? key,
    required SearchStore searchStore,
    required this.searchType,
    this.pageContent,
  })  : _searchStore = searchStore,
        super(key: key);

  final SearchTypeEnum searchType;
  final SearchStore _searchStore;
  final Widget? pageContent;

  @override
  State<RecipeSearchResult> createState() => _RecipeSearchResultState();
}

class _RecipeSearchResultState extends State<RecipeSearchResult> {
  final RecipeHelpersStore helpersStore = serviceLocator<RecipeHelpersStore>();

  @override
  void initState() {
    helpersStore.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (context) {
            if (widget._searchStore.searchText != null &&
                    widget._searchStore.searchText!.isNotEmpty ||
                widget.searchType != SearchTypeEnum.TEXT) {
              return Column(
                children: [
                  Spacing(height: 16),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(
                              left: SizeConverter.relativeWidth(16),
                            ),
                            scrollDirection: Axis.horizontal,
                            children: [
                              FilterButton(
                                onPressed: () {
                                  _showAddFilter(context);
                                },
                                icon: LineAwesomeIcons.filter,
                                text: 'Adicionar filtros',
                                buttonColor: AppColors.whiteColor,
                                textColor: AppColors.darkColor,
                              ),
                              if (widget
                                  ._searchStore.difficulties.isNotEmpty) ...[
                                Spacing(width: 8),
                                FilterButton(
                                  onPressed: () {
                                    widget._searchStore.unsetDifficulties();
                                  },
                                  icon: LineAwesomeIcons.times,
                                  text: 'Dificuldades '
                                      '${widget._searchStore.difficulties.length}',
                                  buttonColor: AppColors.highlightColor,
                                  textColor: AppColors.whiteColor,
                                  borderColor: AppColors.highlightColor,
                                ),
                              ],
                              if (widget._searchStore.categories.isNotEmpty &&
                                  widget.searchType !=
                                      SearchTypeEnum.CATEGORY) ...[
                                Spacing(width: 8),
                                FilterButton(
                                  onPressed: () {
                                    widget._searchStore.unsetCategories();
                                  },
                                  icon: LineAwesomeIcons.times,
                                  text: 'Categorias '
                                      '${widget._searchStore.categories.length}',
                                  buttonColor: AppColors.highlightColor,
                                  textColor: AppColors.whiteColor,
                                  borderColor: AppColors.highlightColor,
                                ),
                              ],
                              if (widget._searchStore.portions.isNotEmpty) ...[
                                Spacing(width: 8),
                                FilterButton(
                                  onPressed: () {
                                    widget._searchStore.unsetPortion();
                                  },
                                  icon: LineAwesomeIcons.times,
                                  text: 'Porções '
                                      '${widget._searchStore.portions}',
                                  buttonColor: AppColors.highlightColor,
                                  textColor: AppColors.whiteColor,
                                  borderColor: AppColors.highlightColor,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        Observer(
          builder: (context) {
            if (widget._searchStore.isSearching || widget.pageContent == null) {
              if (widget._searchStore.isEmptyRecipe) return EmptyRecipe();
              if (widget._searchStore.isLoadingSearch ||
                  helpersStore.isLoadingCategories) {
                return ListShimmer();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget._searchStore.filteredRecipes.length,
                    itemBuilder: (context, index) {
                      SummaryRecipe recipe =
                          widget._searchStore.filteredRecipes[index];
                      return RecipeTile(
                        recipe: recipe,
                        recipeType: widget.searchType,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Spacing(height: 16);
                    },
                  ),
                ],
              );
            }
            return widget.pageContent ?? Container();
          },
        ),
      ],
    );
  }

  _showAddFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FilterModal(
        helpersStore: helpersStore,
        onPressToFilter: widget._searchStore.getFilteredRecipes,
        type: widget.searchType,
      ),
    );
  }
}
