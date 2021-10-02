import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

class RecipeDatasource {
  final HttpService _httpService;

  RecipeDatasource(this._httpService);

  Future<List<SummaryRecipe>> getLatestRecipes() async {
    try {
      final response = await _httpService.get('/recipe/latest');

      return SummaryRecipe.fromJsonList(response.data["content"]);
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null ? e.response?.data['message'] : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<List<SummaryRecipe>> getRecipesByName(String name) async {
    try {
      final response = await _httpService.get('/recipe/name', queryParameters: {"name": name});

      return SummaryRecipe.fromJsonList(response.data["content"]);
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null ? e.response?.data['message'] : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
