import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:round_tech_square/app/core/config/api_config.dart';
import 'package:round_tech_square/app/core/data/interceptors/auth_interceptor.dart';
import 'package:round_tech_square/app/core/data/interceptors/error_interceptor.dart';
import 'package:round_tech_square/app/core/services/api_exception.dart';


class ApiService {
  late final Dio _dio;

  ApiService() {
 
    Map<String, String> headers = {
      'content-Type': 'application/json',
      'accept': 'application/json',
     
    };

    final options = BaseOptions(
      baseUrl: AppUrl.baseUrl,
      headers: headers,
      connectTimeout: AppUrl.connectionTimeout,
      receiveTimeout: AppUrl.receiveTimeout,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);


    _dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(), 
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode, 
        ),
    ]);
  }
    Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
  
      throw ApiException.fromDioError(e);
    } catch (e) {

      throw ApiException.fromDioError(DioException(
        requestOptions: RequestOptions(path: url),
        type: DioExceptionType.unknown,
        message: 'Unexpected error: $e',
      ));
    }
  }
}