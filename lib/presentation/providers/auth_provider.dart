import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';
import 'package:savingmantra/domain/repositories/auth_repository.dart';
import 'package:savingmantra/domain/repositories/i_auth_repository.dart';

class Country {
  final String id;
  final String name;

  Country({required this.id, required this.name});
}

class AuthState {
  final bool isLoading;
  final String? phoneNumber;
  final String? authToken;
  final String? error;
  final List<Country> countries;
  final bool isLoadingCountries;

  AuthState({this.isLoading = false, this.phoneNumber, this.authToken, this.error, this.countries = const [], this.isLoadingCountries = false});

  AuthState copyWith({bool? isLoading, String? phoneNumber, String? authToken, String? error, List<Country>? countries, bool? isLoadingCountries}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authToken: authToken ?? this.authToken,
      error: error ?? this.error,
      countries: countries ?? this.countries,
      isLoadingCountries: isLoadingCountries ?? this.isLoadingCountries,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  IAuthRepository get _authRepository => AuthRepository();

  Future<void> sendLoginOTP(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.sendOTP(phoneNumber, "client");
      if (result['ErrorMsg'] == "success" || result['ErrorMsg'] == "successsendtoregister") {
        state = state.copyWith(isLoading: false, phoneNumber: phoneNumber, authToken: result['Auth']);
      } else {
        throw Exception(result['ErrorMsg'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> sendRegisterOTP(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.sendRegisterOTP(phoneNumber, "client");
      if (result['ErrorMsg'] == "success") {
        state = state.copyWith(isLoading: false, phoneNumber: phoneNumber, authToken: result['Auth']);
      } else {
        throw Exception(result['ErrorMsg'] ?? 'Failed to send registration OTP');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> verifyLoginOTP(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.verifyOTP(state.authToken!, state.phoneNumber!, otp);
      if (result['ErrorMsg'] == "success") {
        final authToken = result['Auth'];
        await LocalStorage.setToken(authToken);
        await LocalStorage.setLoggedIn(true);
        state = state.copyWith(isLoading: false, authToken: authToken);
      } else {
        throw Exception(result['ErrorMsg'] ?? 'Invalid OTP');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> verifyRegisterOTP(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.verifyRegisterOTP(state.authToken!, state.phoneNumber!, otp);
      if (result['ErrorMsg'] == "success") {
        state = state.copyWith(isLoading: false, authToken: result['Auth']);
      } else {
        throw Exception(result['ErrorMsg'] ?? 'Invalid OTP');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> getCountries() async {
    state = state.copyWith(isLoadingCountries: true);
    try {
      final result = await _authRepository.getCountries();
      List<Country> countries = [];
      if (result['data'] is List) {
        for (var data in result['data']) {
          countries.add(Country(id: data['CountryID'].toString(), name: data['CountryName'] ?? ''));
        }
      }
      state = state.copyWith(countries: countries, isLoadingCountries: false);
    } catch (e) {
      state = state.copyWith(isLoadingCountries: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> registerUser({required String fullName, required String email, required String countryId, required String city, required String authPin}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authRepository.registerUser(
        authToken: state.authToken!,
        phoneNumber: state.phoneNumber!,
        fullName: fullName,
        email: email,
        countryId: countryId,
        city: city,
        authPin: authPin,
      );
      if (result['ErrorMsg'] == "success") {
        state = state.copyWith(isLoading: false);
      } else {
        throw Exception(result['ErrorMsg'] ?? 'Registration failed');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
