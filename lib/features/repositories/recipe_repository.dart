import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe_datasource.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<SummaryRecipe>>> getLatestRecipes();
  Future<Either<Failure, List<SummaryRecipe>>> getFilteredRecipes(String name);
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByIngredients(List<String> ingredients);
}

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDatasource _datasource;

  RecipeRepositoryImpl(
    this._datasource,
  );

  @override
  Future<Either<Failure, List<SummaryRecipe>>> getLatestRecipes() async {
    try {
      return Right(await _datasource.getLatestRecipes());
    } on ServerException catch (e) {
      return Left(ServerFailure(errorText: e.errorText));
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SummaryRecipe>>> getFilteredRecipes(String name) async {
    try {
      return Right(await _datasource.getRecipesByName(name));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorText: e.errorText));
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByIngredients(List<String> ingredients) async {
    try {
      return Right(await _datasource.getRecipeByIngredients(ingredients));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorText: e.errorText));
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }
}
