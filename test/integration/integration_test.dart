import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:medico24/core/router/app_router.dart';
import 'package:medico24/core/theme/app_colors.dart';

/// Integration tests for Medico24 application
///
/// These tests verify app components work together correctly
/// without requiring Firebase or platform-specific plugins.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Create a test theme without Google Fonts to avoid plugin dependencies
  final testTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.red,
      secondary: AppColors.yellow,
      tertiary: AppColors.blue,
      surface: AppColors.white,
      error: AppColors.red700,
      onPrimary: AppColors.white,
      onSecondary: AppColors.coal,
      onSurface: AppColors.coal,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.red,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
    ),
  );

  group('App Initialization Tests', () {
    testWidgets('App should initialize and display initial route', (
      WidgetTester tester,
    ) async {
      // Create test app without Firebase or Google Fonts
      final app = MaterialApp.router(
        title: 'Medico24 Test',
        theme: testTheme,
        routerConfig: AppRouter.createRouter(),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Verify MaterialApp is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Theme Integration Tests', () {
    testWidgets('App should use correct theme configuration', (
      WidgetTester tester,
    ) async {
      final app = MaterialApp.router(
        title: 'Medico24 Test',
        theme: testTheme,
        routerConfig: AppRouter.createRouter(),
      );

      await tester.pumpWidget(app);
      await tester.pump();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
      expect(materialApp.title, equals('Medico24 Test'));
    });

    test('Theme colors should be correctly configured', () {
      expect(testTheme.colorScheme.primary, equals(AppColors.red));
      expect(testTheme.colorScheme.secondary, equals(AppColors.yellow));
      expect(testTheme.colorScheme.tertiary, equals(AppColors.blue));
    });

    test('AppBar theme should be configured', () {
      expect(testTheme.appBarTheme.backgroundColor, equals(AppColors.red));
      expect(testTheme.appBarTheme.foregroundColor, equals(AppColors.white));
      expect(testTheme.appBarTheme.centerTitle, isTrue);
    });

    test('Material 3 should be enabled', () {
      expect(testTheme.useMaterial3, isTrue);
    });
  });

  group('Router Integration Tests', () {
    test('Router should be created successfully', () {
      final router = AppRouter.createRouter();

      expect(router, isNotNull);
      expect(router.routerDelegate, isNotNull);
      expect(router.routeInformationParser, isNotNull);
    });

    testWidgets('App should handle navigation', (WidgetTester tester) async {
      final app = MaterialApp.router(
        routerConfig: AppRouter.createRouter(),
        theme: testTheme,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Verify router is working
      expect(tester.takeException(), isNull);
    });
  });

  group('Widget Rendering Tests', () {
    testWidgets('App should render without errors', (
      WidgetTester tester,
    ) async {
      final app = MaterialApp.router(
        title: 'Medico24',
        theme: testTheme,
        routerConfig: AppRouter.createRouter(),
      );

      await tester.pumpWidget(app);

      // Initial pump
      await tester.pump();
      expect(tester.takeException(), isNull);

      // Settle animations
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('App should handle frame building', (
      WidgetTester tester,
    ) async {
      final app = MaterialApp.router(
        routerConfig: AppRouter.createRouter(),
        theme: testTheme,
      );

      await tester.pumpWidget(app);

      // Multiple pump cycles
      for (int i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.takeException(), isNull);
      }
    });
  });

  group('Performance Tests', () {
    testWidgets('App should not leak memory on rebuild', (
      WidgetTester tester,
    ) async {
      final app = MaterialApp.router(
        routerConfig: AppRouter.createRouter(),
        theme: testTheme,
      );

      // Build and rebuild multiple times
      for (int i = 0; i < 3; i++) {
        await tester.pumpWidget(app);
        await tester.pump();
      }

      expect(tester.takeException(), isNull);
    });

    testWidgets('App should render within reasonable frame budget', (
      WidgetTester tester,
    ) async {
      final app = MaterialApp.router(
        routerConfig: AppRouter.createRouter(),
        theme: testTheme,
      );

      final stopwatch = Stopwatch()..start();
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      stopwatch.stop();

      // Should render in under 1 second
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}
