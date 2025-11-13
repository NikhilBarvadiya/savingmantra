class ApiConstants {
  static const String baseUrl = 'http://advisor.careai.in/';
  static const String login = 'mclienthome/MobileLoginWithEmail';
  static const String register = 'ClientAPI/ClientRegistration';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
}
