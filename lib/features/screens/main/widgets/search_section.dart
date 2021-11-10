import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/utils/size_converter.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/empty_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/list_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/app_search_field.dart';
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
        Spacing(height: 24),
        IngredientSearchResult(
          searchStore: _searchStore,
          pageContent: pageContent,
        ),
      ],
    );
  }
}

class IngredientSearchResult extends StatelessWidget {
  const IngredientSearchResult({
    Key? key,
    required SearchStore searchStore,
    this.recipeType,
    this.pageContent,
  })  : _searchStore = searchStore,
        super(key: key);

  final FilteredIngredientsEnum? recipeType;
  final SearchStore _searchStore;
  final Widget? pageContent;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_searchStore.isSearching || pageContent == null) {
          if (_searchStore.isEmptyRecipe) return EmptyRecipe();
          if (_searchStore.isLoadingSearch) {
            return ListShimmer();
          }
          return Column(
            children: [
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
                  return Spacing(height: index == 0 ? 0 : 16);
                },
              ),
            ],
          );
        }
        return pageContent ?? Container();
      },
    );
  }
}
