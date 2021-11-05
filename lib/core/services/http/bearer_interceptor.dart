import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/core/services/storage_service.dart';
import 'package:pratudo/core/utils/navigation_without_context.dart';

class BearerInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storageService;
  final NavigationWithoutContext _navigation;
  BearerInterceptor({
    required Dio dio,
    required StorageService storageService,
    required NavigationWithoutContext navigationWithoutContext,
  })  : this._storageService = storageService,
        this._dio = dio,
        this._navigation = navigationWithoutContext;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _storageService.read(key: 'accessToken') ?? "";
    _dio.lock();
    Map<dynamic, dynamic> json = options.data ?? {};
    options.data = json;
    if (token != null && token.isNotEmpty)
      options.headers.addAll({
        "Authorization": "Bearer " + token,
      });

    _dio.unlock();
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, BODY : ${err.response!.data}, request : ${err.requestOptions.data}');
    if (err.response!.statusCode == 401 || err.response!.statusCode == 403) {
      _storageService.delete(key: 'accessToken');
      _navigation.pushNamedAndRemoveUntil(Routes.login);
    }
    return super.onError(err, handler);
  }
}
