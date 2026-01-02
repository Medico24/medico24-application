import 'package:dio/dio.dart';
import 'package:medico24/core/api/api_constants.dart';
import 'package:medico24/core/api/models/auth_model.dart';

class AuthApiService {
  AuthApiService(this._dio);
  final Dio _dio;

  Future<LoginResponse> googleCallback(GoogleAuthRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.firebaseVerify,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data!);
  }

  Future<TokenRefreshResponse> refreshToken(TokenRefreshRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/auth/refresh',
      data: request.toJson(),
    );
    return TokenRefreshResponse.fromJson(response.data!);
  }

  Future<void> logout(TokenRefreshRequest request) async {
    await _dio.post<void>('/api/v1/auth/logout', data: request.toJson());
  }
}
