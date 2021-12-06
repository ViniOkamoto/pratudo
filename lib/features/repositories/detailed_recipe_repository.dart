import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe/detailed_recipe_datasource.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';

abstract class DetailedRecipeRepository {
  Future<Either<Failure, ExperienceGainedModel>> commentRecipe(
    String content,
    String id,
  );

  Future<Either<Failure, ExperienceGainedModel>> rateAndCommentRecipe(
    String content,
    String id,
    double rate,
  );

  Future<Either<Failure, ExperienceGainedModel>> rateRecipe(
    String id,
    double rate,
  );
}

class DetailedRecipeRepositoryImpl implements DetailedRecipeRepository {
  final DetailedRecipeDatasource _datasource;

  DetailedRecipeRepositoryImpl(
    this._datasource,
  );

  @override
  Future<Either<Failure, ExperienceGainedModel>> commentRecipe(
      String content, String id) async {
    try {
      return Right(
        await _datasource.commentRecipe(content, id),
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
  Future<Either<Failure, ExperienceGainedModel>> rateAndCommentRecipe(
      String content, String id, double rate) async {
    try {
      return Right(await _datasource.rateAndCommentRecipe(content, id, rate));
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
  Future<Either<Failure, ExperienceGainedModel>> rateRecipe(
      String id, double rate) async {
    try {
      return Right(await _datasource.rateRecipe(id, rate));
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
