import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _accessTokenKey = 'accessToken';

  Future<void> saveAuthData({
    required String accessToken,

  }) async {
    print('TokenStorage: Saving auth data: token=$accessToken');
    try {
      await Future.wait([
        _storage.write(key: _accessTokenKey, value: accessToken),
       
      ]).timeout(const Duration(seconds: 5), onTimeout: () {
        throw Exception('Storage write timed out');
      });
      print('TokenStorage: Auth data saved successfully');
    } catch (e) {
      print('TokenStorage: Error saving auth data: $e');
      rethrow;
    }
  }

  Future<String?> getToken() async {
    print('TokenStorage: Reading token');
    try {
      final token = await _storage.read(key: _accessTokenKey).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              throw Exception('Storage read timed out');
            },
          );
      print('TokenStorage: Token read: $token');
      return token;
    } catch (e) {
      print('TokenStorage: Error reading token: $e');
      return null;
    }
  }


  Future<void> clearToken() async {
    print('TokenStorage: Clearing auth data');
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
    
      ]).timeout(const Duration(seconds: 5), onTimeout: () {
        throw Exception('Storage delete timed out');
      });
      print('TokenStorage: Auth data cleared');
    } catch (e) {
      print('TokenStorage: Error clearing auth data: $e');
      rethrow;
    }
  }
}