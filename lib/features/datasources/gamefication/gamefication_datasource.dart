import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/models/user_progress/user_progress_model.dart';

class GamificationDatasource {
  final HttpService _httpService;

  GamificationDatasource(this._httpService);

  Future<UserProgressModel> getUserProgress() async {
    try {
      final response = await _httpService.get('/user/performance');

      return UserProgressModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerException(
        errorText: e.response?.data['message'] != null ? e.response?.data['message'] : "Erro Inesperado",
      );
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
