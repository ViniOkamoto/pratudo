import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers/recipe_helpers_datasource.dart';
import 'package:pratudo/features/datasources/recipe/recipe_helpers/recipe_helpers_localsource.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

abstract class RecipeHelperRepository {
  Future<Either<Failure, List<RecipeHelperModel>>> getCategories();
  Future<Either<Failure, List<UnitModel>>> getUnitsOfMeasurement();
  Future<Either<Failure, List<RecipeHelperModel>>> getTrends();
}

class RecipeHelperRepositoryImpl implements RecipeHelperRepository {
  final RecipeHelperDatasource _datasource;
  final RecipeHelperLocalSource _localSource;

  RecipeHelperRepositoryImpl(this._datasource, this._localSource);

  @override
  Future<Either<Failure, List<RecipeHelperModel>>> getCategories() async {
    try {
      List<RecipeHelperModel> categories = _localSource.getCategories();
      if (categories.isEmpty) {
        categories = await _datasource.getCategories();
        await _localSource.saveCategories(categories);
      }
      return Right(categories);
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
  Future<Either<Failure, List<RecipeHelperModel>>> getTrends() async {
    try {
      return Right(await _datasource.getTrends());
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
  Future<Either<Failure, List<UnitModel>>> getUnitsOfMeasurement() async {
    try {
      List<UnitModel> units = _localSource.getUnitsOfMeasurement();
      if (units.isEmpty) {
        units = await _datasource.getUnitsOfMeasurement();
        await _localSource.saveUnitsOfMeasure(units);
      }
      return Right(units);
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
