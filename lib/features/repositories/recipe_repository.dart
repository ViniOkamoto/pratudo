import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe/recipe_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByFilters(
      {String filterValue});
  Future<Either<Failure, List<SummaryRecipe>>> getRecipe(
      RecipeQueryParams recipeQueryParams);

  Future<Either<Failure, List<SummaryRecipe>>> myRecipes();
  Future<Either<Failure, ExperienceGainedModel>> createRecipe(
      RecipeCreationModel recipeCreation);
  Future<Either<Failure, DetailedRecipeModel>> getRecipeById(String id);
}

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDatasource _datasource;

  RecipeRepositoryImpl(
    this._datasource,
  );

  @override
  Future<Either<Failure, List<SummaryRecipe>>> getRecipeByFilters(
      {String filterValue = 'latest'}) async {
    try {
      return Right(
        await _datasource.getRecipeByFilters(filterValue: filterValue),
      );
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
  Future<Either<Failure, List<SummaryRecipe>>> getRecipe(
      RecipeQueryParams recipeQueryParams) async {
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

  @override
  Future<Either<Failure, ExperienceGainedModel>> createRecipe(
      RecipeCreationModel recipeCreation) async {
    try {
      return Right(await _datasource.createRecipe(recipeCreation));
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
  Future<Either<Failure, DetailedRecipeModel>> getRecipeById(String id) async {
    try {
      return Right(await _datasource.getRecipeById(id));
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
  Future<Either<Failure, List<SummaryRecipe>>> myRecipes() async {
    try {
      return Right(await _datasource.myRecipes());
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
