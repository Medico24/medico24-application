import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:medico24/core/api/services/environment_api_service.dart';
import 'package:medico24/core/api/models/environment_model.dart';
import '../../../helpers/test_helpers.dart';
import '../../../helpers/mock_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDio mockDio;
  late EnvironmentApiService service;

  setUp(() {
    mockDio = MockDio();
    service = EnvironmentApiService(mockDio);
  });

  group('EnvironmentApiService', () {
    group('getEnvironmentConditions', () {
      test('should fetch environment conditions successfully', () async {
        // Arrange
        const latitude = 40.7128;
        const longitude = -74.0060;
        final responseData = MockData.mockEnvironmentConditionsJson;

        when(
          mockDio.get<Map<String, dynamic>>(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => TestHelpers.mockResponse<Map<String, dynamic>>(
            data: responseData,
          ),
        );

        // Act
        final result = await service.getEnvironmentConditions(
          latitude: latitude,
          longitude: longitude,
        );

        // Assert
        expect(result, isA<EnvironmentConditionsModel>());
        expect(result.aqi, 35);
        expect(result.aqiCategory, 'Good');
        expect(result.temperature, 21.3);
        expect(result.condition, 'Clear sky');
        verify(
          mockDio.get<Map<String, dynamic>>(
            any,
            queryParameters: {'lat': latitude, 'lng': longitude},
          ),
        ).called(1);
      });

      test('should throw DioException on network error', () async {
        // Arrange
        const latitude = 40.7128;
        const longitude = -74.0060;

        when(
          mockDio.get<Map<String, dynamic>>(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        // Act & Assert
        expect(
          () async => await service.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('should throw exception on empty response', () async {
        // Arrange
        const latitude = 40.7128;
        const longitude = -74.0060;

        when(
          mockDio.get<Map<String, dynamic>>(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: null,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act & Assert
        expect(
          () async => await service.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
