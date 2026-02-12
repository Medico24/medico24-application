import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('MaterialApp should build successfully', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const Center(child: Text('Test Content')),
          ),
        ),
      );

      // Assert
      expect(find.text('Test'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('Button tap should trigger callback', (
      WidgetTester tester,
    ) async {
      // Arrange
      int counter = 0;
      void incrementCounter() {
        counter++;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: incrementCounter,
                child: const Text('Tap Me'),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      // Assert
      expect(counter, 1);
    });

    testWidgets('TextField should accept input', (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter text'),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextField), 'Test input');
      await tester.pump();

      // Assert
      expect(controller.text, 'Test input');
      expect(find.text('Test input'), findsOneWidget);
    });

    testWidgets('ListView should scroll', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) =>
                  ListTile(title: Text('Item $index')),
            ),
          ),
        ),
      );

      // Assert - First item visible
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 50'), findsNothing);

      // Act - Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -5000));
      await tester.pumpAndSettle();

      // Assert - Scrolled items visible
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('Icon should be displayed', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Icon(Icons.home))),
      );

      // Assert
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('Checkbox should toggle state', (WidgetTester tester) async {
      // Arrange
      bool isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
            ),
          ),
        ),
      );

      // Assert initial state
      expect(isChecked, false);

      // Act - Tap checkbox
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      // Assert changed state
      expect(isChecked, true);
    });

    testWidgets('Form validation should work', (WidgetTester tester) async {
      // Arrange
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      // Act - Validate empty form
      final isValid = formKey.currentState!.validate();

      // Assert
      expect(isValid, false);
      await tester.pump();
      expect(find.text('Field is required'), findsOneWidget);
    });

    testWidgets('AlertDialog should display', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Test Dialog'),
                      content: const Text('Dialog content'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Act - Show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test Dialog'), findsOneWidget);
      expect(find.text('Dialog content'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });
}
