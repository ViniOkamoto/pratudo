import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/datasources/recipe/recipe_query_params.dart';
import 'package:pratudo/features/models/create_recipe/recipe_creation_model.dart';
import 'package:pratudo/features/models/gamification/experience_gained_model.dart';
import 'package:pratudo/features/models/recipe/detailed_recipe_model.dart';
import 'package:pratudo/features/models/recipe/summary_recipe.dart';

class RecipeDatasource {
  final HttpService _httpService;

  RecipeDatasource(this._httpService);

  Future<List<SummaryRecipe>> getRecipeByFilters(
      {String filterValue = 'latest'}) async {
    try {
      final response = await _httpService.get(
        '/recipe/trend',
        queryParameters: {
          "filter": filterValue,
          "size": 5,
        },
      );

      return SummaryRecipe.fromJsonList(response.data["content"]);
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

  Future<List<SummaryRecipe>> getRecipes(
    RecipeQueryParams recipeQueryParams,
  ) async {
    try {
      final response = await _httpService.get('/recipe',
          queryParameters: recipeQueryParams.toJson());
      return SummaryRecipe.fromJsonList(response.data["content"]);
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

  Future<List<SummaryRecipe>> myRecipes() async {
    try {
      final response = await _httpService.get('/recipe/my-recipes');
      return SummaryRecipe.fromJsonList(response.data["content"]);
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

  Future<ExperienceGainedModel> createRecipe(
      RecipeCreationModel recipeCreation) async {
    try {
      final response = await _httpService.post(
        '/recipe',
        data: recipeCreation.toJson(),
      );
      return ExperienceGainedModel.fromJson(response.data);
    } on DioError catch (e) {
      final Map<dynamic, dynamic>? response = e.response?.data;
      throw ServerException(
          errorText: response?.containsKey('message') ?? false
              ? response!['message']
              : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<DetailedRecipeModel> getRecipeById(String id) async {
    try {
      final response = await _httpService.get('/recipe/$id');
      return DetailedRecipeModel.fromJson(response.data);
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
