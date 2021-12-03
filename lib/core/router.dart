import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';
import 'package:pratudo/features/screens/cache_recipe/cache_recipe_page.dart';
import 'package:pratudo/features/screens/create_recipe/create_recipe_page.dart';
import 'package:pratudo/features/screens/detailed_recipe/detailed_recipe_page.dart';
import 'package:pratudo/features/screens/login/login_page.dart';
import 'package:pratudo/features/screens/main/main_page.dart';
import 'package:pratudo/features/screens/register/register_page.dart';
import 'package:pratudo/features/screens/search_by_ingredient/search_by_ingredient_page.dart';
import 'package:pratudo/features/screens/shared/filtered_ingredients/filtered_ingredients_page.dart';
import 'package:pratudo/features/screens/splash/splash_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
          settings: settings,
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: settings,
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
          settings: settings,
        );
      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: settings,
        );
      case Routes.searchByIngredient:
        return MaterialPageRoute(
          builder: (_) => SearchByIngredientPage(),
          settings: settings,
        );
      case Routes.filteredIngredients:
        FilteredIngredientsPageParams params =
            settings.arguments as FilteredIngredientsPageParams;
        return MaterialPageRoute(
          builder: (_) => FilteredIngredientsPage(params),
          settings: settings,
        );
      case Routes.createRecipe:
        return MaterialPageRoute(
          builder: (_) => CreateRecipePage(),
          settings: settings,
        );
      case Routes.detailedRecipe:
        String id = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailedRecipePage(id: id),
          settings: settings,
        );
      case Routes.cachedRecipe:
        CacheRecipeModel recipe = settings.arguments as CacheRecipeModel;
        return MaterialPageRoute(
          builder: (_) => CacheRecipePage(recipe: recipe),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
