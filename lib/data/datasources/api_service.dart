import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:savingmantra/core/constants/api_constants.dart';
import 'package:savingmantra/data/datasources/local_storage.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl, connectTimeout: ApiConstants.connectTimeout, receiveTimeout: ApiConstants.receiveTimeout, headers: ApiConstants.headers));
  var logger = Logger();

  void init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = LocalStorage.getToken();
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          logger.i('API Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('API Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          logger.e('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Generic PUT method
  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  dynamic _handleError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      final message = data['message'] ?? 'Something went wrong';
      throw Exception(message);
    } else {
      throw Exception('Network error: ${error.message}');
    }
  }
}
