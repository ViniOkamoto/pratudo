import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';

class DetailedRecipeDatasource {
  final HttpService _httpService;

  DetailedRecipeDatasource(this._httpService);

  Future<ExperienceGainedModel> commentRecipe(String content, String id) async {
    try {
      final response = await _httpService.post(
        '/comment/$id',
        data: {
          'content': content,
        },
      );

      return ExperienceGainedModel.fromJson(response.data);
    } on DioError catch (e) {
      final Map<dynamic, dynamic>? response = e.response?.data;

      throw ServerException(
        errorText: response?.containsKey('message') ?? false
            ? response!['message']
            : "Erro Inesperado",
      );
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<ExperienceGainedModel> rateAndCommentRecipe(
      String content, String id, double rate) async {
    try {
      final response = await _httpService.post(
        '/rating/rateAndComment/$id',
        data: {
          'rate': rate,
          'content': content,
        },
      );

      return ExperienceGainedModel.fromJson(response.data);
    } on DioError catch (e) {
      final Map<dynamic, dynamic>? response = e.response?.data;

      throw ServerException(
        errorText: response?.containsKey('message') ?? false
            ? response!['message']
            : "Erro Inesperado",
      );
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<ExperienceGainedModel> rateRecipe(String id, double rate) async {
    try {
      final response = await _httpService.post(
        '/rating/$id',
        data: {
          'rate': rate,
        },
      );

      return ExperienceGainedModel.fromJson(response.data);
    } on DioError catch (e) {
      final Map<dynamic, dynamic>? response = e.response?.data;

      throw ServerException(
        errorText: response?.containsKey('message') ?? false
            ? response!['message']
            : "Erro Inesperado",
      );
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
