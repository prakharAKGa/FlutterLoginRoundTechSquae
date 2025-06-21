import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/core/config/api_config.dart';
import 'package:round_tech_square/app/core/config/token_storage.dart';
import 'package:round_tech_square/app/core/services/api_exception.dart';
import 'package:round_tech_square/app/core/services/api_service.dart';
import 'package:round_tech_square/app/core/utils/enums.dart';
import 'package:round_tech_square/app/core/utils/snackbar.dart';
import 'package:round_tech_square/app/core/utils/validators.dart';
import 'package:round_tech_square/app/routes/routes.dart';


class LoginController extends GetxController {
  final RxBool _isPasswordVisible = false.obs;
  final Rx<PostApiStatus> _loginStatus = PostApiStatus.initial.obs;
  final TextEditingController emailController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController(); 
  final TokenStorage _tokenStorage = TokenStorage(); 
  final ApiService _apiService = ApiService(); 

  bool get isPasswordVisible => _isPasswordVisible.value;

  PostApiStatus get loginStatus => _loginStatus.value;


  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

 
  Future<void> login() async {
    _loginStatus.value = PostApiStatus.loading; 
      if (Validations.isEmpty(emailController.text.trim())) {
      CustomSnackbar.error("Email cannot be empty");
      _loginStatus.value = PostApiStatus.error;
      return;
    }
    if(Validations.isEmpty(passwordController.text.trim())) {
      CustomSnackbar.error("Password cannot be empty");
      _loginStatus.value = PostApiStatus.error;
      return;
    }

  
    if (!Validations.emailValidator(emailController.text.trim())) {
      CustomSnackbar.error("Please enter a valid email address");
      _loginStatus.value = PostApiStatus.error;
      return;
    }
    if (!Validations.passwordValidator(passwordController.text.trim())) {
      CustomSnackbar.error("Password must be at least 6 characters long");
      _loginStatus.value = PostApiStatus.error;
      return;
    }
  

    try {
      final response = await _apiService.post(
        AppUrl.login,
        data: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

   
      if (response.statusCode == 201) {
        final accessToken = response.data['access_token'] as String;
        await _tokenStorage.saveAuthData(accessToken: accessToken);
        CustomSnackbar.success("Login successful"); 
        _loginStatus.value = PostApiStatus.success;
        Get.offAllNamed(RoutesName.homeScreen); 
      } else {
     
        _loginStatus.value = PostApiStatus.error;
      }
    } on ApiException catch (e) {
   
   print(e);
      
      _loginStatus.value = PostApiStatus.error;
    } catch (e) {
      print(e);
    
      CustomSnackbar.error("An unexpected error occurred");
      _loginStatus.value = PostApiStatus.error;
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}