import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:medico24/core/api/services/environment_api_service.dart';
import 'package:medico24/core/repositories/environment_repository.dart';
import '../../helpers/mock_data.dart';

@GenerateMocks([EnvironmentApiService])
import 'environment_repository_test.mocks.dart';

void main() {
  late MockEnvironmentApiService mockApiService;
  late EnvironmentRepository repository;

  setUp(() {
    mockApiService = MockEnvironmentApiService();
    repository = EnvironmentRepository(mockApiService);
  });

  group('EnvironmentRepository', () {
    group('getEnvironmentConditions', () {
      test(
        'should return environment conditions on successful API call',
        () async {
          // Arrange
          final latitude = 40.7128;
          final longitude = -74.0060;
          final expectedConditions = MockData.mockEnvironmentConditions;

          when(
            mockApiService.getEnvironmentConditions(
              latitude: latitude,
              longitude: longitude,
            ),
          ).thenAnswer((_) async => expectedConditions);

          // Act
          final result = await repository.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          );

          // Assert
          expect(result, equals(expectedConditions));
          verify(
            mockApiService.getEnvironmentConditions(
              latitude: latitude,
              longitude: longitude,
            ),
          ).called(1);
        },
      );

      test('should throw DioException on API network error', () async {
        // Arrange
        final latitude = 40.7128;
        final longitude = -74.0060;

        when(
          mockApiService.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        // Act & Assert
        expect(
          () async => await repository.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('should throw exception on API general error', () async {
        // Arrange
        final latitude = 40.7128;
        final longitude = -74.0060;

        when(
          mockApiService.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
        ).thenThrow(Exception('API Error'));

        // Act & Assert
        expect(
          () async => await repository.getEnvironmentConditions(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
