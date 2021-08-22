import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/models/register_user_model.dart';

class AuthenticationDatasource {
  final HttpService _httpService;

  AuthenticationDatasource(this._httpService);

  Future<void> register(RegisterUserModel userModel) async {
    try {
      await _httpService.post('/user', data: userModel.toJson());
      return null;
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null ? e.response?.data['message'] : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final result = await _httpService.post('/auth', data: {"email": email, "password": password});
      return result.data["token"];
    } on DioError catch (e) {
      throw ServerException(
        errorText: e.response?.statusCode == 400 ? "Usuário ou senha inválidos" : "Erro Inesperado",
      );
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
