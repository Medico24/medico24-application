import 'package:flutter_test/flutter_test.dart';
import 'package:medico24/core/api/models/auth_model.dart';
import '../../../helpers/mock_data.dart';

void main() {
  group('LoginResponse', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final response = LoginResponse.fromJson(MockData.mockLoginResponseJson);

        // Assert
        expect(response.accessToken, 'test_access_token_123');
        expect(response.refreshToken, 'test_refresh_token_456');
        expect(response.tokenType, 'Bearer');
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final response = MockData.mockLoginResponse;

        // Act
        final json = response.toJson();

        // Assert
        expect(json['access_token'], 'test_access_token_123');
        expect(json['refresh_token'], 'test_refresh_token_456');
        expect(json['token_type'], 'Bearer');
      });
    });
  });

  group('GoogleAuthRequest', () {
    test('should create instance with id token', () {
      // Act
      final request = GoogleAuthRequest(idToken: 'test_token');

      // Assert
      expect(request.idToken, 'test_token');
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final request = MockData.mockGoogleAuthRequest;

        // Act
        final json = request.toJson();

        // Assert
        expect(json['id_token'], 'test_id_token');
      });
    });
  });

  group('TokenRefreshRequest', () {
    test('should create instance with refresh token', () {
      // Act
      final request = TokenRefreshRequest(refreshToken: 'test_refresh');

      // Assert
      expect(request.refreshToken, 'test_refresh');
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final request = TokenRefreshRequest(refreshToken: 'test_refresh_123');

        // Act
        final json = request.toJson();

        // Assert
        expect(json['refresh_token'], 'test_refresh_123');
      });
    });
  });

  group('TokenRefreshResponse', () {
    test('should correctly deserialize from JSON', () {
      // Arrange
      final json = {
        'access_token': 'new_access_token',
        'refresh_token': 'new_refresh_token',
        'token_type': 'Bearer',
      };

      // Act
      final response = TokenRefreshResponse.fromJson(json);

      // Assert
      expect(response.accessToken, 'new_access_token');
      expect(response.refreshToken, 'new_refresh_token');
      expect(response.tokenType, 'Bearer');
    });
  });
}
