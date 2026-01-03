import 'package:flutter_test/flutter_test.dart';
import 'package:medico24/core/api/models/pharmacy_model.dart';
import '../../../helpers/mock_data.dart';

void main() {
  group('PharmacyLocationModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final location = PharmacyLocationModel.fromJson(
          MockData.mockPharmacyLocationJson,
        );

        // Assert
        expect(location.id, 'location123');
        expect(location.pharmacyId, 'pharmacy123');
        expect(location.addressLine, '123 Main St');
        expect(location.city, 'Test City');
        expect(location.state, 'Test State');
        expect(location.country, 'Test Country');
        expect(location.pincode, '12345');
        expect(location.latitude, 40.7128);
        expect(location.longitude, -74.0060);
        expect(location.createdAt, isA<DateTime>());
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final location = MockData.mockPharmacyLocation;

        // Act
        final json = location.toJson();

        // Assert
        expect(json['id'], 'location123');
        expect(json['pharmacy_id'], 'pharmacy123');
        expect(json['address_line'], '123 Main St');
        expect(json['city'], 'Test City');
        expect(json['state'], 'Test State');
        expect(json['country'], 'Test Country');
        expect(json['pincode'], '12345');
        expect(json['latitude'], 40.7128);
        expect(json['longitude'], -74.0060);
      });
    });
  });

  group('PharmacyHoursModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final hours = PharmacyHoursModel.fromJson(
          MockData.mockPharmacyHoursJson,
        );

        // Assert
        expect(hours.id, 'hours123');
        expect(hours.pharmacyId, 'pharmacy123');
        expect(hours.dayOfWeek, 1);
        expect(hours.openTime, '09:00:00');
        expect(hours.closeTime, '18:00:00');
        expect(hours.isClosed, false);
      });
    });

    group('dayName getter', () {
      test('should return correct day name', () {
        // Arrange
        final hours = MockData.mockPharmacyHours;

        // Act & Assert
        expect(hours.dayName, 'Monday');
      });
    });
  });

  group('PharmacyModel', () {
    group('fromJson', () {
      test('should correctly deserialize from JSON', () {
        // Act
        final pharmacy = PharmacyModel.fromJson(MockData.mockPharmacyJson);

        // Assert
        expect(pharmacy.id, 'pharmacy123');
        expect(pharmacy.name, 'Test Pharmacy');
        expect(pharmacy.description, 'A test pharmacy');
        expect(pharmacy.phone, '+1234567890');
        expect(pharmacy.email, 'pharmacy@example.com');
        expect(pharmacy.isVerified, true);
        expect(pharmacy.isActive, true);
        expect(pharmacy.rating, 4.5);
        expect(pharmacy.ratingCount, 100);
        expect(pharmacy.supportsDelivery, true);
        expect(pharmacy.supportsPickup, true);
        expect(pharmacy.createdAt, isA<DateTime>());
        expect(pharmacy.updatedAt, isA<DateTime>());
        expect(pharmacy.location, isA<PharmacyLocationModel>());
        expect(pharmacy.hours, isA<List<PharmacyHoursModel>>());
        expect(pharmacy.hours?.length, 1);
      });

      test('should handle rating as String', () {
        // Arrange
        final jsonWithStringRating = {
          ...MockData.mockPharmacyJson,
          'rating': '4.5',
        };

        // Act
        final pharmacy = PharmacyModel.fromJson(jsonWithStringRating);

        // Assert
        expect(pharmacy.rating, 4.5);
      });

      test('should handle null rating', () {
        // Arrange
        final jsonWithNullRating = {
          ...MockData.mockPharmacyJson,
          'rating': null,
        };

        // Act
        final pharmacy = PharmacyModel.fromJson(jsonWithNullRating);

        // Assert
        expect(pharmacy.rating, 0.0);
      });
    });

    group('toJson', () {
      test('should correctly serialize to JSON', () {
        // Arrange
        final pharmacy = MockData.mockPharmacy;

        // Act
        final json = pharmacy.toJson();

        // Assert
        expect(json['id'], 'pharmacy123');
        expect(json['name'], 'Test Pharmacy');
        expect(json['description'], 'A test pharmacy');
        expect(json['phone'], '+1234567890');
        expect(json['email'], 'pharmacy@example.com');
        expect(json['is_verified'], true);
        expect(json['is_active'], true);
        expect(json['rating'], 4.5);
        expect(json['rating_count'], 100);
        expect(json['supports_delivery'], true);
        expect(json['supports_pickup'], true);
        expect(json['location'], isNotNull);
        expect(json['hours'], isA<List>());
      });
    });

    group('fullAddress getter', () {
      test('should return formatted address', () {
        // Arrange
        final pharmacy = MockData.mockPharmacy;

        // Act
        final address = pharmacy.fullAddress;

        // Assert
        expect(address, contains('123 Main St'));
        expect(address, contains('Test City'));
        expect(address, contains('Test State'));
        expect(address, contains('Test Country'));
      });
    });
  });

  group('RatingConverter', () {
    test('should convert num to double', () {
      // Arrange
      const converter = RatingConverter();

      // Act & Assert
      expect(converter.fromJson(4), 4.0);
      expect(converter.fromJson(4.5), 4.5);
    });

    test('should convert String to double', () {
      // Arrange
      const converter = RatingConverter();

      // Act & Assert
      expect(converter.fromJson('4.5'), 4.5);
      expect(converter.fromJson('3'), 3.0);
    });

    test('should handle invalid String', () {
      // Arrange
      const converter = RatingConverter();

      // Act & Assert
      expect(converter.fromJson('invalid'), 0.0);
    });

    test('should handle null', () {
      // Arrange
      const converter = RatingConverter();

      // Act & Assert
      expect(converter.fromJson(null), 0.0);
    });
  });
}
