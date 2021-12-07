import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pratudo/core/services/di/service_locator.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/empty_recipe.dart';
import 'package:pratudo/features/screens/main/widgets/list_shimmer.dart';
import 'package:pratudo/features/screens/main/widgets/recipe_tile.dart';
import 'package:pratudo/features/screens/my_recipes/my_recipes_store.dart';
import 'package:pratudo/features/widgets/secondary_app_bar.dart';
import 'package:pratudo/features/widgets/spacing.dart';

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({Key? key}) : super(key: key);

  @override
  _MyRecipePageState createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {
  final MyRecipesStore store = serviceLocator<MyRecipesStore>();

  @override
  void initState() {
    store.getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        text: 'Minhas Receitas',
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Observer(
                    builder: (context) {
                      if (store.recipes.isEmpty &&
                          !store.isLoading &&
                          !store.hasError) return EmptyRecipe();
                      if (store.isLoading) {
                        return ListShimmer();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacing(height: 16),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: store.recipes.length,
                            itemBuilder: (context, index) {
                              SummaryRecipe recipe = store.recipes[index];
                              return RecipeTile(
                                recipe: recipe,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Spacing(height: 16);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
