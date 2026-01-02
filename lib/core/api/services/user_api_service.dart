import 'package:dio/dio.dart';
import 'package:medico24/core/api/models/user_model.dart';

class UserApiService {
  UserApiService(this._dio);
  final Dio _dio;

  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get<Map<String, dynamic>>('/api/v1/users/me');
    return UserModel.fromJson(response.data!);
  }

  Future<UserModel> updateCurrentUser(UserUpdateRequest request) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/api/v1/users/me',
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data!);
  }

  Future<void> deleteCurrentUser() async {
    await _dio.delete<void>('/api/v1/users/me');
  }

  Future<UserModel> completeOnboarding() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/v1/users/me/onboard',
    );
    return UserModel.fromJson(response.data!);
  }

  Future<UserModel> getUserProfile(String userId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/users/$userId/profile',
    );
    return UserModel.fromJson(response.data!);
  }
}
