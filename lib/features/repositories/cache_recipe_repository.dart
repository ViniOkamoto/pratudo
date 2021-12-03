import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe/recipe_localsource.dart';
import 'package:pratudo/features/models/recipe/cache_recipe_model.dart';

abstract class CacheRecipeRepository {
  Future<Either<Failure, void>> saveRecipe(CacheRecipeModel recipe);
  Future<Either<Failure, void>> deleteRecipeById(String id);
  Future<Either<Failure, List<CacheRecipeModel>>> getCachedRecipes();
  Future<Either<Failure, bool>> checkIfIsCached(String id);
}

class CacheRecipeRepositoryImpl implements CacheRecipeRepository {
  final RecipeLocalSource _localSource;

  CacheRecipeRepositoryImpl(
    this._localSource,
  );

  @override
  Future<Either<Failure, bool>> checkIfIsCached(String id) async {
    try {
      return Right(_localSource.checkIfIsCached(id));
    } on LocalFailure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipeById(String id) async {
    try {
      return Right(_localSource.deleteRecipeById(id));
    } on LocalFailure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CacheRecipeModel>>> getCachedRecipes() async {
    try {
      return Right(_localSource.getCachedRecipes());
    } on LocalFailure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveRecipe(CacheRecipeModel recipe) async {
    try {
      return Right(_localSource.saveRecipe(recipe));
    } on LocalFailure catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }
}
