import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:drift/native.dart';
import 'package:medico24/core/database/database.dart';
import 'package:medico24/core/repositories/environment_repository.dart';
import 'package:medico24/presentation/environment/environment_card.dart';
import '../../helpers/mock_data.dart';

@GenerateMocks([EnvironmentRepository])
import 'environment_card_test.mocks.dart';

void main() {
  late MockEnvironmentRepository mockRepository;
  late AppDatabase testDatabase;

  setUp(() async {
    mockRepository = MockEnvironmentRepository();

    // Create an in-memory database for testing
    testDatabase = AppDatabase.forTesting(NativeDatabase.memory());

    // Insert test location data
    await testDatabase.updateCurrentLocation(
      title: 'Test Location',
      address: '123 Test Street',
      city: 'Test City',
      latitude: 40.7128, // New York coordinates
      longitude: -74.0060,
    );
  });

  tearDown(() async {
    await testDatabase.close();
  });

  group('EnvironmentCard Widget Tests', () {
    testWidgets('should build without errors', (WidgetTester tester) async {
      // Arrange
      when(
        mockRepository.getEnvironmentConditions(
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
        ),
      ).thenAnswer((_) async => MockData.mockEnvironmentConditions);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: testDatabase,
              backgroundImage: null, // Disable background image for testing
            ),
          ),
        ),
      );

      // Wait for async operations to complete
      await tester.pumpAndSettle();

      // Assert - Just check that it builds
      expect(find.byType(EnvironmentCard), findsOneWidget);
    });

    testWidgets('should have proper layout structure', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockRepository.getEnvironmentConditions(
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
        ),
      ).thenAnswer((_) async => MockData.mockEnvironmentConditions);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: testDatabase,
              backgroundImage: null, // Disable background image for testing
            ),
          ),
        ),
      );

      // Wait for async operations to complete
      await tester.pumpAndSettle();

      // Assert - Check for basic layout elements
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should display error when location is not available', (
      WidgetTester tester,
    ) async {
      // Arrange - Create database without location
      final emptyDatabase = AppDatabase.forTesting(NativeDatabase.memory());

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: emptyDatabase,
              backgroundImage: null,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Location not available'), findsOneWidget);

      await emptyDatabase.close();
    });

    testWidgets('should display error when coordinates are null', (
      WidgetTester tester,
    ) async {
      // Arrange - Create database with location but no coordinates
      final dbWithNullCoords = AppDatabase.forTesting(NativeDatabase.memory());
      await dbWithNullCoords.updateCurrentLocation(
        title: 'Test',
        address: 'Test Address',
        city: 'Test City',
        latitude: null,
        longitude: null,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: dbWithNullCoords,
              backgroundImage: null,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Location not available'), findsOneWidget);

      await dbWithNullCoords.close();
    });

    testWidgets('should call repository with correct coordinates', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockRepository.getEnvironmentConditions(
          latitude: 40.7128,
          longitude: -74.0060,
        ),
      ).thenAnswer((_) async => MockData.mockEnvironmentConditions);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: testDatabase,
              backgroundImage: null,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      verify(
        mockRepository.getEnvironmentConditions(
          latitude: 40.7128,
          longitude: -74.0060,
        ),
      ).called(1);
    });

    testWidgets('should display error when API call fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(
        mockRepository.getEnvironmentConditions(
          latitude: anyNamed('latitude'),
          longitude: anyNamed('longitude'),
        ),
      ).thenThrow(Exception('API Error'));

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnvironmentCard(
              environmentRepository: mockRepository,
              database: testDatabase,
              backgroundImage: null,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Failed to load environment data'), findsOneWidget);
    });
  });
}
