import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(this._dio);

  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get('/api/v1/users/me');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> updateCurrentUser(UserUpdateRequest request) async {
    final response = await _dio.patch(
      '/api/v1/users/me',
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data);
  }

  Future<void> deleteCurrentUser() async {
    await _dio.delete('/api/v1/users/me');
  }

  Future<UserModel> completeOnboarding() async {
    final response = await _dio.post('/api/v1/users/me/onboard');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUserProfile(String userId) async {
    final response = await _dio.get('/api/v1/users/$userId/profile');
    return UserModel.fromJson(response.data);
  }
}
