import 'package:savingmantra/core/constants/api_constants.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/domain/repositories/auth/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<Map<String, dynamic>> sendOTP(String phoneNumber, String loginType) async {
    try {
      final response = await _apiService.post(
        ApiConstants.sendOTP,
        {'UserName': phoneNumber, 'LoginType': loginType},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> sendRegisterOTP(String phoneNumber, String loginType) async {
    try {
      final response = await _apiService.post(
        ApiConstants.sendRegisterOTP,
        {'ContactNo': phoneNumber, 'LoginType': loginType},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to send registration OTP: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOTP(String authToken, String phoneNumber, String otp) async {
    try {
      final response = await _apiService.post(
        ApiConstants.verifyOTP,
        {'Auth': authToken, 'ContactNo': phoneNumber, 'OTP': otp},
      );
      return response;
    } catch (e) {
      throw Exception('OTP verification failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> verifyRegisterOTP(String authToken, String phoneNumber, String otp) async {
    try {
      final response = await _apiService.post(
        ApiConstants.verifyRegisterOTP,
        {'Auth': authToken, 'ContactNo': phoneNumber, 'OTP': otp},
      );
      return response;
    } catch (e) {
      throw Exception('Registration OTP verification failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> registerUser({
    required String authToken,
    required String phoneNumber,
    required String fullName,
    required String email,
    required String countryId,
    required String city,
    required String authPin,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.registerClient,
        {
          'Auth': authToken,
          'ContactNo': phoneNumber,
          'FullName': fullName,
          'EmailID': email,
          'CountryID': countryId,
          'City': city,
          'AuthPin': authPin,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getCountries() async {
    try {
      final response = await _apiService.post(ApiConstants.getCountries, {});
      return response;
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }
}
