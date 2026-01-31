import 'package:flutter_test/flutter_test.dart';
import 'package:medico24/core/api/models/environment_model.dart';
import '../../../helpers/mock_data.dart';

void main() {
  group('EnvironmentConditionsModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final environment = EnvironmentConditionsModel.fromJson(
          MockData.mockEnvironmentConditionsJson,
        );

        // Assert
        expect(environment.aqi, 35);
        expect(environment.aqiCategory, 'Good');
        expect(environment.temperature, 21.3);
        expect(environment.condition, 'Clear sky');
      });

      test('should handle different AQI values', () {
        // Arrange
        final testCases = [
          {
            'aqi': 25,
            'aqi_category': 'Good',
            'temperature': 20.0,
            'condition': 'Sunny',
          },
          {
            'aqi': 75,
            'aqi_category': 'Moderate',
            'temperature': 25.5,
            'condition': 'Cloudy',
          },
          {
            'aqi': 150,
            'aqi_category': 'Unhealthy',
            'temperature': 15.2,
            'condition': 'Rainy',
          },
        ];

        for (final testCase in testCases) {
          // Act
          final environment = EnvironmentConditionsModel.fromJson(testCase);

          // Assert
          expect(environment.aqi, testCase['aqi']);
          expect(environment.aqiCategory, testCase['aqi_category']);
          expect(environment.temperature, testCase['temperature']);
          expect(environment.condition, testCase['condition']);
        }
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final environment = MockData.mockEnvironmentConditions;

        // Act
        final json = environment.toJson();

        // Assert
        expect(json['aqi'], 35);
        expect(json['aqi_category'], 'Good');
        expect(json['temperature'], 21.3);
        expect(json['condition'], 'Clear sky');
      });
    });
  });
}
