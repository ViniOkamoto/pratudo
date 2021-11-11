import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers_datasource.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';

abstract class RecipeHelperRepository {
  Future<Either<Failure, List<RecipeHelperModel>>> getCategories();
  Future<Either<Failure, List<RecipeHelperModel>>> getFilters();
}

class RecipeHelperRepositoryImpl implements RecipeHelperRepository {
  final RecipeHelperDatasource _datasource;

  RecipeHelperRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<RecipeHelperModel>>> getCategories() async {
    try {
      return Right(await _datasource.getCategories());
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
  Future<Either<Failure, List<RecipeHelperModel>>> getFilters() async {
    try {
      return Right(await _datasource.getCriteria());
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
