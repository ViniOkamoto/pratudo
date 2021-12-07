import 'package:flutter/material.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/screens/main/widgets/search_section.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_enum.dart';
import 'package:pratudo/features/stores/shared/search_store.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';

class FilteredIngredientsPageParams {
  final SearchTypeEnum pageType;
  final List<String>? ingredients;
  final RecipeHelperModel? category;
  FilteredIngredientsPageParams(this.pageType,
      {this.ingredients, this.category});
}

class FilteredIngredientsPage extends StatefulWidget {
  FilteredIngredientsPage(this.params);
  final FilteredIngredientsPageParams params;

  @override
  State<FilteredIngredientsPage> createState() =>
      _FilteredIngredientsPageState();
}

class _FilteredIngredientsPageState extends State<FilteredIngredientsPage> {
  final SearchStore _store = serviceLocator<SearchStore>();

  @override
  void initState() {
    super.initState();
    List<String> categories = [];
    if (widget.params.category != null) {
      categories.add(widget.params.category!.key);
    }
    _store.getFilteredRecipes(
      RecipeQueryParams(
        categories: categories,
        ingredients: widget.params.ingredients,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: widget.params.pageType.getTopBarName(
          widget.params.category?.value,
        ),
      ),
      body: SingleChildScrollView(
        child: RecipeSearchResult(
          searchStore: _store,
          searchType: widget.params.pageType,
        ),
      ),
    );
  }
}
