import 'package:dio/dio.dart';
import 'package:round_tech_square/app/core/utils/snackbar.dart';


class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorTitle = "Error";
    String errorMessage = "An unexpected error occurred";


    if (err.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Connection Timeout";
    } else if (err.type == DioExceptionType.unknown &&
        err.message?.contains("SocketException") == true) {
      errorMessage = "No Internet";
    } else if (err.response != null && err.response!.statusCode != 200) {
      switch (err.response!.statusCode) {
        case 400:
          errorTitle = "Bad Request";
          errorMessage = '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Invalid request'}';
          break;
        case 401:
          errorTitle = "Unauthorized";
          errorMessage = '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Access denied'}';
          break;
        case 403:
          errorTitle = "Forbidden";
          errorMessage = '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Access denied'}';
          break;
        case 404:
          errorTitle = "Not Found";
          errorMessage = '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Resource not found'}';
          break;
        case 500:
          errorTitle = "Server Error";
          errorMessage = 'Internal Server Error';
          break;
        default:
          errorTitle = "Error";
          errorMessage = '${err.response?.statusMessage ?? 'Unknown error'}';
          break;
      }
    }


    if (err.type != DioExceptionType.cancel && err.response?.statusCode != 200) {
      CustomSnackbar.error("$errorTitle: $errorMessage");
    }

    handler.next(err); 
  }
}