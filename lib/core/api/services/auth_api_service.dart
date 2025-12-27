import 'package:dio/dio.dart';
import '../api_constants.dart';
import '../models/auth_model.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService(this._dio);

  Future<LoginResponse> googleCallback(GoogleAuthRequest request) async {
    final response = await _dio.post(
      ApiConstants.firebaseVerify,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  Future<TokenRefreshResponse> refreshToken(TokenRefreshRequest request) async {
    final response = await _dio.post(
      '/api/v1/auth/refresh',
      data: request.toJson(),
    );
    return TokenRefreshResponse.fromJson(response.data);
  }

  Future<void> logout(TokenRefreshRequest request) async {
    await _dio.post('/api/v1/auth/logout', data: request.toJson());
  }
}
