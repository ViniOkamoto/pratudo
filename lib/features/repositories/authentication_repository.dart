import 'package:dartz/dartz.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/features/datasources/authentication_datasource.dart';
import 'package:pratudo/features/datasources/authentication_local_datasource.dart';
import 'package:pratudo/features/models/register_user_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> register(RegisterUserModel registerUserModel);
  Future<Either<Failure, void>> login({required String email, required String password});
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDatasource _datasource;
  final AuthenticationLocalDatasource _localDatasource;

  AuthenticationRepositoryImpl(this._datasource, this._localDatasource);

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

  @override
  Future<Either<Failure, void>> login({required String email, required String password}) async {
    try {
      String token = await _datasource.login(email, password);

      await _localDatasource.saveAuthentication(token);

      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorText: e.errorText));
    } on LocalCacheException catch (e) {
      return Left(LocalFailure(errorText: e.errorText));
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          errorText: e.toString(),
        ),
      );
    }
  }
}
