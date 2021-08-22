import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/authentication_datasource.dart';
import 'package:pratudo/features/models/register_user_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> register(RegisterUserModel registerUserModel);
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource _datasource;

  AuthenticationRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, void>> register(RegisterUserModel registerUserModel) async {
    try {
      await _datasource.register(registerUserModel);

      return Right(null);
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
