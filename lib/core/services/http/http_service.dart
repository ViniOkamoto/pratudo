import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pratudo/core/resources/common_exceptions.dart';
import 'package:pratudo/core/resources/constants.dart';

class HttpService {
  late Dio _dio;
  final List<Interceptor>? interceptors;
  late String baseUrl;

  HttpService({required Dio dio, this.interceptors}) {
    this._dio = dio;
    _dio
      ..options.connectTimeout = Constants.httpTimeout
      ..options.receiveTimeout = Constants.receiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    baseUrl = Constants.baseUrl;
    _dio.interceptors.clear();

    if (interceptors != null) _dio.interceptors.addAll(interceptors!);
  }

  Future<Response> get(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e, s) {
      _defaultHttpExceptionHandler(e, s);

      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e, s) {
      _defaultHttpExceptionHandler(e, s);

      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e, s) {
      _defaultHttpExceptionHandler(e, s);

      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e, s) {
      _defaultHttpExceptionHandler(e, s);

      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e, s) {
      _defaultHttpExceptionHandler(e, s);
      throw e;
    } catch (e) {
      throw e;
    }
  }

  _defaultHttpExceptionHandler(e, s) {
    if (e.response != null && e.response.data.toString().contains('ECONNREFUSED')) {
      throw ConnectionRefused(errorText: 'Conexão recusada');
    }

    if (e.type == DioErrorType.connectTimeout) {
      throw ConnectionTimeOut(errorText: "Tempo de conexão com servidor excedido");
    }
  }

  close() {
    _dio.close();
  }
}
