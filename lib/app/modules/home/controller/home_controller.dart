import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/core/config/api_config.dart';
import 'package:round_tech_square/app/core/config/token_storage.dart';
import 'package:round_tech_square/app/core/model/profile_model.dart';
import 'package:round_tech_square/app/core/services/api_service.dart';
import 'package:round_tech_square/app/core/utils/snackbar.dart';
import 'package:round_tech_square/app/routes/routes.dart';


class HomeController extends GetxController {
  final TokenStorage _tokenStorage = TokenStorage();
  final ApiService _apiService = ApiService();
  final RxString _token = ''.obs; 
  final RxString _welcomeMessage = ''.obs;
  final Rx<ProfileModel?> _profile = Rx<ProfileModel?>(null); 

  ProfileModel? get profile => _profile.value;


  String get welcomeMessage => _welcomeMessage.value;

  @override
  void onInit() async {
    super.onInit();
    _token.value = await _tokenStorage.getToken() ?? '';
    _welcomeMessage.value = "Hey! Welcome to Round Tech Square.";
    await fetchProfile();
  }

 
  Future<void> fetchProfile() async {
    if (_token.value.isEmpty) {
      CustomSnackbar.error("No authentication token available.");
      _profile.value = null;
      return;
    }
    try {
      final response = await _apiService.get(
        AppUrl.profile,
        options: Options(headers: {'Authorization': 'Bearer ${_token.value}'}),
      );
      if (response.statusCode == 200) {
        _profile.value = ProfileModel.fromJson(response.data);
      } else {
        CustomSnackbar.error("Failed to load profile: ${response.data['message'] ?? 'Unknown error'}");
        _profile.value = null;
      }
    } on DioException catch (e) {
      CustomSnackbar.error("Error fetching profile: ${e.message ?? 'Network error'}");
      _profile.value = null;
    } catch (e) {
      CustomSnackbar.error("Unexpected error fetching profile");
      _profile.value = null;
    }
  }


  Future<void> logout() async {
    try {
      await _tokenStorage.clearToken();
      Get.offAllNamed(RoutesName.loginScreen);
    } catch (e) {
      print('Logout error: $e');
      CustomSnackbar.error("Error logging out. Please try again.");
    }
  }
}