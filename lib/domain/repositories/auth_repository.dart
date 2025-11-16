import 'package:savingmantra/core/constants/api_constants.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';
import 'package:savingmantra/data/models/user_model.dart';
import 'package:savingmantra/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final ApiService _apiService = ApiService();

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiService.post(ApiConstants.login, {'email': email, 'password': password});
      final user = UserModel.fromJson(response['user']);
      final token = response['token'];
      await LocalStorage.setToken(token);
      await LocalStorage.setUserData(user.toJson().toString());
      await LocalStorage.setLoggedIn(true);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await _apiService.post(ApiConstants.register, {'name': name, 'email': email, 'password': password});
      final user = UserModel.fromJson(response['user']);
      final token = response['token'];
      await LocalStorage.setToken(token);
      await LocalStorage.setUserData(user.toJson().toString());
      await LocalStorage.setLoggedIn(true);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    await _apiService.post(ApiConstants.forgotPassword, {'email': email});
  }

  @override
  Future<void> logout() async {
    await LocalStorage.clearAll();
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await _apiService.get('/user/profile');
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return LocalStorage.isLoggedIn() && LocalStorage.getToken().isNotEmpty;
  }
}
