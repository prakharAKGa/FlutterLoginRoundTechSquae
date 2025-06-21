class AppUrl {
  AppUrl._();

  static const String _serverUrl = 'https://api.escuelajs.co';


  static const String baseUrl = "$_serverUrl/api/v1";






  static const Duration receiveTimeout = Duration(seconds: 60);


  static const Duration connectionTimeout = Duration(seconds: 60);

  static const String login = "$baseUrl/auth/login";
   static const String profile = "$baseUrl/auth/profile";

}
