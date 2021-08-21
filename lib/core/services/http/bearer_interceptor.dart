import 'package:dio/dio.dart';
import 'package:pratudo/core/services/storage_service.dart';

class BearerInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storageService;
  BearerInterceptor({
    required Dio dio,
    required StorageService storageService,
  })  : this._storageService = storageService,
        this._dio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await _storageService.read(key: 'accessToken') ?? "";
    _dio.lock();
    Map<dynamic, dynamic> json = options.data ?? {};
    options.data = json;
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
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, BODY : ${err.response!.data}');
    if (err.response!.statusCode == 401) {
      ///TODO: implement token refresh
    }
    return super.onError(err, handler);
  }
}
