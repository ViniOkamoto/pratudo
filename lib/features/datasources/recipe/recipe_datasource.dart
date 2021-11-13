import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

class RecipeDatasource {
  final HttpService _httpService;

  RecipeDatasource(this._httpService);

  Future<List<SummaryRecipe>> getRecipeByFilters({String filterValue = 'latest'}) async {
    try {
      final response = await _httpService.get('/recipe', queryParameters: {"filter": filterValue});

      return SummaryRecipe.fromJsonList(response.data["content"]);
    } on DioError catch (e) {
      dynamic error = e.response?.data;
      throw ServerException(
          errorText: !(error is String) && error['message'] != null ? error['message'] : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<List<SummaryRecipe>> getRecipes(RecipeQueryParams recipeQueryParams) async {
    try {
      final response = await _httpService.get('/recipe', queryParameters: recipeQueryParams.toJson());
      return SummaryRecipe.fromJsonList(response.data["content"]);
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null ? e.response?.data['message'] : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
