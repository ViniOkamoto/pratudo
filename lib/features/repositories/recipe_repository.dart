import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByFilters({String filterValue});
  Future<Either<Failure, List<SummaryRecipe>>> getRecipe(RecipeQueryParams recipeQueryParams);
}

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDatasource _datasource;

  RecipeRepositoryImpl(
    this._datasource,
  );

  @override
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByFilters({String filterValue = 'latest'}) async {
    try {
      return Right(await _datasource.getRecipeByFilters(filterValue: filterValue));
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
  Future<Either<Failure, List<SummaryRecipe>>> getRecipe(RecipeQueryParams recipeQueryParams) async {
    try {
      return Right(await _datasource.getRecipes(recipeQueryParams));
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
