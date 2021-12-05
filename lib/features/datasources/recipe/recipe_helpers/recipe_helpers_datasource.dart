import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/services/http/http_service.dart';
import 'package:pratudo/features/models/recipe/recipe_helper_model.dart';
import 'package:pratudo/features/models/unit_model.dart';

class RecipeHelperDatasource {
  final HttpService _httpService;

  RecipeHelperDatasource(this._httpService);

  Future<List<RecipeHelperModel>> getCategories() async {
    try {
      final response = await _httpService.get('/recipe/categories');

      return RecipeHelperModel.fromJsonList(response.data);
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null
              ? e.response?.data['message']
              : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<List<RecipeHelperModel>> getTrends() async {
    try {
      final response = await _httpService.get('/recipe/trends');

      return RecipeHelperModel.fromJsonList(response.data);
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null
              ? e.response?.data['message']
              : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }

  Future<List<UnitModel>> getUnitsOfMeasurement() async {
    try {
      final response = await _httpService.get('/recipe/units-of-measure');
      List<UnitModel> units = UnitModel.fromJsonList(response.data);
      return units;
    } on DioError catch (e) {
      throw ServerException(
          errorText: e.response?.data['message'] != null
              ? e.response?.data['message']
              : "Erro Inesperado");
    } catch (e) {
      throw ServerException(errorText: e.toString());
    }
  }
}
