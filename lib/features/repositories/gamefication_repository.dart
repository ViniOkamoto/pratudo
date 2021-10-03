import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/gamefication/gamefication_datasource.dart';
import 'package:pratudo/features/models/user_progress/user_progress_model.dart';

abstract class GamificationRepository {
  Future<Either<Failure, UserProgressModel>> getUserProgress();
}

class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationDatasource _datasource;

  GamificationRepositoryImpl(
    this._datasource,
  );

  @override
  Future<Either<Failure, UserProgressModel>> getUserProgress() async {
    try {
      return Right(await _datasource.getUserProgress());
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
