import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:medico24/core/api/models/environment_model.dart';
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
  });
}
