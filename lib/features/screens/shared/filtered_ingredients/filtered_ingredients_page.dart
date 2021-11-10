import 'package:flutter/material.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/screens/main/widgets/search_section.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';

class FilteredIngredientsPageParams {
  final FilteredIngredientsEnum pageType;
  final List<String>? ingredients;
  FilteredIngredientsPageParams(this.pageType, {this.ingredients});
}

class FilteredIngredientsPage extends StatefulWidget {
  FilteredIngredientsPage(this.params);
  final FilteredIngredientsPageParams params;

  @override
  State<FilteredIngredientsPage> createState() => _FilteredIngredientsPageState();
}

class _FilteredIngredientsPageState extends State<FilteredIngredientsPage> {
  final SearchStore _store = serviceLocator<SearchStore>();

  @override
  void initState() {
    super.initState();
    _store.getFilteredRecipes(
      searchType: widget.params.pageType,
      ingredients: widget.params.ingredients,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: widget.params.pageType.getTopBarName(),
      ),
      body: IngredientSearchResult(
        searchStore: _store,
        recipeType: widget.params.pageType,
      ),
    );
  }
}
