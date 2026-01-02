import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:medico24/core/api/models/user_model.dart';
import 'package:medico24/core/api/services/user_api_service.dart';
import 'package:medico24/core/database/database.dart';

class UserRepository {
  UserRepository(this._apiService, this._database);
  final UserApiService _apiService;
  final AppDatabase _database;
  final Logger _logger = Logger();

  /// Fetch user from API and cache
  Future<UserModel> fetchAndCacheUser() async {
    try {
      final user = await _apiService.getCurrentUser();
      await _cacheUser(user);
      return user;
    } on DioException catch (e) {
      _logger.e('Failed to fetch user from API', error: e);

      // Return cached user on error
      final cached = await getCachedUser();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  /// Get cached user
  Future<UserModel?> getCachedUser() async {
    try {
      final cached = await _database.getCachedUser();
      if (cached == null) return null;

      return UserModel(
        id: cached.id,
        firebaseUid: cached.firebaseUid,
        email: cached.email,
        emailVerified: cached.emailVerified,
        authProvider: cached.authProvider,
        fullName: cached.fullName,
        givenName: cached.givenName,
        familyName: cached.familyName,
        photoUrl: cached.photoUrl,
        phone: cached.phone,
        role: cached.role,
        isActive: cached.isActive,
        isOnboarded: cached.isOnboarded,
        createdAt: cached.createdAt,
        updatedAt: cached.updatedAt,
        lastLoginAt: cached.lastLoginAt,
      );
    } catch (e) {
      _logger.e('Error getting cached user', error: e);
      return null;
    }
  }

  /// Update user profile
  Future<UserModel> updateUser(UserUpdateRequest request) async {
    try {
      final user = await _apiService.updateCurrentUser(request);
      await _cacheUser(user);
      return user;
    } catch (e) {
      _logger.e('Failed to update user', error: e);
      rethrow;
    }
  }

  /// Complete onboarding
  Future<UserModel> completeOnboarding() async {
    try {
      final user = await _apiService.completeOnboarding();
      await _cacheUser(user);
      return user;
    } catch (e) {
      _logger.e('Failed to complete onboarding', error: e);
      rethrow;
    }
  }

  /// Cache user in local database
  Future<void> _cacheUser(UserModel user) async {
    try {
      final companion = CachedUserCompanion(
        id: Value(user.id),
        firebaseUid: Value(user.firebaseUid),
        email: Value(user.email),
        emailVerified: Value(user.emailVerified),
        authProvider: Value(user.authProvider),
        fullName: Value(user.fullName),
        givenName: Value(user.givenName),
        familyName: Value(user.familyName),
        photoUrl: Value(user.photoUrl),
        phone: Value(user.phone),
        role: Value(user.role),
        isActive: Value(user.isActive),
        isOnboarded: Value(user.isOnboarded),
        createdAt: Value(user.createdAt),
        updatedAt: Value(user.updatedAt),
        lastLoginAt: Value(user.lastLoginAt),
        lastSyncedAt: Value(DateTime.now()),
      );

      await _database.insertOrUpdateCachedUser(companion);
    } catch (e) {
      _logger.e('Error caching user', error: e);
    }
  }

  /// Clear cached user data
  Future<void> clearCache() async {
    await _database.clearCachedUser();
  }
}
