import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/core/config/api_config.dart';
import 'package:round_tech_square/app/core/config/token_storage.dart';
import 'package:round_tech_square/app/core/utils/snackbar.dart';
import 'package:round_tech_square/app/routes/routes.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage = TokenStorage();


  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    if (options.path != AppUrl.login.split(AppUrl.baseUrl)[1]) {
      final token = await _tokenStorage.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }


  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && await _tokenStorage.getToken() != null) {
 
      CustomSnackbar.error("Session expired. Please log in again.");
      await _tokenStorage.clearToken();
      Get.offAllNamed(RoutesName.loginScreen); 
    }
    handler.next(err);
  }
}