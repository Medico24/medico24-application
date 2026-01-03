import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:medico24/core/api/services/auth_api_service.dart';
import 'package:medico24/core/api/models/auth_model.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthApiService service;

  setUp(() {
    mockDio = MockDio();
    service = AuthApiService(mockDio);
  });

  group('AuthApiService', () {
    group('googleCallback', () {
      test('should authenticate with Google ID token successfully', () async {
        // Arrange
        final request = MockData.mockGoogleAuthRequest;
        final responseData = MockData.mockLoginResponseJson;

        when(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).thenAnswer(
          (_) async => TestHelpers.mockResponse<Map<String, dynamic>>(
            data: responseData,
          ),
        );

        // Act
        final result = await service.googleCallback(request);

        // Assert
        expect(result, isA<LoginResponse>());
        expect(result.accessToken, 'test_access_token_123');
        expect(result.refreshToken, 'test_refresh_token_456');
        expect(result.tokenType, 'Bearer');
        verify(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).called(1);
      });

      test('should throw DioException on network error', () async {
        // Arrange
        final request = MockData.mockGoogleAuthRequest;

        when(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            error: 'Network error',
          ),
        );

        // Act & Assert
        expect(
          () => service.googleCallback(request),
          throwsA(isA<DioException>()),
        );
      });

      test('should throw DioException on 401 unauthorized', () async {
        // Arrange
        final request = MockData.mockGoogleAuthRequest;

        when(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).thenThrow(
          TestHelpers.mockDioException(
            statusCode: 401,
            message: 'Invalid credentials',
          ),
        );

        // Act & Assert
        expect(
          () => service.googleCallback(request),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('refreshToken', () {
      test('should refresh token successfully', () async {
        // Arrange
        final request = TokenRefreshRequest(refreshToken: 'test_refresh_token');
        final responseData = {
          'access_token': 'new_access_token',
          'refresh_token': 'new_refresh_token',
          'token_type': 'Bearer',
        };

        when(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).thenAnswer(
          (_) async => TestHelpers.mockResponse<Map<String, dynamic>>(
            data: responseData,
          ),
        );

        // Act
        final result = await service.refreshToken(request);

        // Assert
        expect(result, isA<TokenRefreshResponse>());
        expect(result.accessToken, 'new_access_token');
        expect(result.refreshToken, 'new_refresh_token');
        expect(result.tokenType, 'Bearer');
        verify(
          mockDio.post<Map<String, dynamic>>(
            '/api/v1/auth/refresh',
            data: anyNamed('data'),
          ),
        ).called(1);
      });

      test('should handle expired refresh token', () async {
        // Arrange
        final request = TokenRefreshRequest(refreshToken: 'expired_token');

        when(
          mockDio.post<Map<String, dynamic>>(any, data: anyNamed('data')),
        ).thenThrow(
          TestHelpers.mockDioException(
            statusCode: 401,
            message: 'Refresh token expired',
          ),
        );

        // Act & Assert
        expect(
          () => service.refreshToken(request),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('logout', () {
      test('should logout successfully', () async {
        // Arrange
        final request = TokenRefreshRequest(refreshToken: 'test_refresh_token');

        when(
          mockDio.post<void>(any, data: anyNamed('data')),
        ).thenAnswer((_) async => TestHelpers.mockResponse<void>(data: null));

        // Act
        await service.logout(request);

        // Assert
        verify(
          mockDio.post<void>('/api/v1/auth/logout', data: anyNamed('data')),
        ).called(1);
      });

      test('should handle logout errors gracefully', () async {
        // Arrange
        final request = TokenRefreshRequest(refreshToken: 'test_refresh_token');

        when(mockDio.post<void>(any, data: anyNamed('data'))).thenThrow(
          TestHelpers.mockDioException(
            statusCode: 500,
            message: 'Server error',
          ),
        );

        // Act & Assert
        expect(() => service.logout(request), throwsA(isA<DioException>()));
      });
    });
  });
}
