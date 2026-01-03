import 'package:flutter_test/flutter_test.dart';
import 'package:medico24/core/api/models/user_model.dart';
import '../../../helpers/mock_data.dart';

void main() {
  group('UserModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final user = UserModel.fromJson(MockData.mockUserJson);

        // Assert
        expect(user.id, 'user123');
        expect(user.firebaseUid, 'firebase123');
        expect(user.email, 'test@example.com');
        expect(user.emailVerified, true);
        expect(user.authProvider, 'google');
        expect(user.fullName, 'Test User');
        expect(user.givenName, 'Test');
        expect(user.familyName, 'User');
        expect(user.photoUrl, 'https://example.com/photo.jpg');
        expect(user.phone, '+1234567890');
        expect(user.role, 'patient');
        expect(user.isActive, true);
        expect(user.isOnboarded, true);
        expect(user.createdAt, isA<DateTime>());
        expect(user.updatedAt, isA<DateTime>());
        expect(user.lastLoginAt, isA<DateTime>());
      });

      test('should handle null optional fields', () {
        // Arrange
        final jsonWithNulls = {
          ...MockData.mockUserJson,
          'full_name': null,
          'given_name': null,
          'family_name': null,
          'photo_url': null,
          'phone': null,
          'last_login_at': null,
        };

        // Act
        final user = UserModel.fromJson(jsonWithNulls);

        // Assert
        expect(user.fullName, isNull);
        expect(user.givenName, isNull);
        expect(user.familyName, isNull);
        expect(user.photoUrl, isNull);
        expect(user.phone, isNull);
        expect(user.lastLoginAt, isNull);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final user = MockData.mockUser;

        // Act
        final json = user.toJson();

        // Assert
        expect(json['id'], 'user123');
        expect(json['firebase_uid'], 'firebase123');
        expect(json['email'], 'test@example.com');
        expect(json['email_verified'], true);
        expect(json['auth_provider'], 'google');
        expect(json['full_name'], 'Test User');
        expect(json['given_name'], 'Test');
        expect(json['family_name'], 'User');
        expect(json['photo_url'], 'https://example.com/photo.jpg');
        expect(json['phone'], '+1234567890');
        expect(json['role'], 'patient');
        expect(json['is_active'], true);
        expect(json['is_onboarded'], true);
      });
    });

    group('equality', () {
      test('should be equal when all fields match', () {
        // Arrange
        final user1 = MockData.mockUser;
        final user2 = UserModel.fromJson(MockData.mockUserJson);

        // Assert
        expect(user1.id, equals(user2.id));
        expect(user1.email, equals(user2.email));
      });
    });
  });
}
