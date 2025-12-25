# Contributing to Medico24

Thank you for your interest in contributing to Medico24! This document provides guidelines and setup instructions for developers working on this project.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Development Environment Setup](#development-environment-setup)
- [Firebase Configuration](#firebase-configuration)
- [Building the Project](#building-the-project)
- [Project Architecture](#project-architecture)
- [Code Style Guidelines](#code-style-guidelines)
- [Database Migrations](#database-migrations)
- [Testing](#testing)
- [Common Issues](#common-issues)

## 🔧 Prerequisites

Before you begin, ensure you have the following installed on your development machine:

### Required Tools

1. **Flutter SDK** (version 3.10.4 or higher)
   - Download from: https://docs.flutter.dev/get-started/install
   - Verify installation: `flutter --version`

2. **Dart SDK** (version 3.10.4 or higher)
   - Comes bundled with Flutter
   - Verify: `dart --version`

3. **Android Studio** (for Android development)
   - Download from: https://developer.android.com/studio
   - Install Android SDK and emulator
   - Configure Android SDK path in Flutter: `flutter config --android-sdk /path/to/sdk`

4. **Xcode** (for iOS development - macOS only)
   - Download from Mac App Store
   - Install command line tools: `xcode-select --install`
   - Accept license: `sudo xcodebuild -license accept`

5. **Git**
   - Download from: https://git-scm.com/downloads
   - Verify: `git --version`

6. **VS Code** or **Android Studio** (recommended IDEs)
   - VS Code Flutter extension: `ms-dart-tools.flutter`
   - Dart extension: `dart-code.dart-code`

### Verify Flutter Setup

Run the Flutter doctor command to check your setup:

```bash
flutter doctor -v
```

Ensure all checkmarks are green before proceeding.

## 🚀 Development Environment Setup

### 1. Clone the Repository

```bash
git clone https://github.com/rohansen856/medico24
cd medico24
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

This will download all required packages listed in `pubspec.yaml`.

### 3. Set Up Environment Variables

Create a `.env` file in the root directory:

```bash
# .env
GOOGLE_WEB_CLIENT_ID=your-firebase-web-client-id.apps.googleusercontent.com
```

**Important**: Never commit the `.env` file to version control. It's already included in `.gitignore`.

### 4. Generate Database Code

Medico24 uses Drift for database management. Generate the required code:

```bash
dart run build_runner build
```

For continuous code generation during development:

```bash
dart run build_runner watch
```

To clean and rebuild:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 🔥 Firebase Configuration

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use an existing one
3. Enable Google Analytics (optional)

### 2. Configure Android

1. In Firebase Console, add an Android app
2. Package name: `com.example.medico24` (or your configured package)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### 3. Configure iOS

1. In Firebase Console, add an iOS app
2. Bundle ID: `com.example.medico24` (or your configured bundle)
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### 4. Enable Authentication

1. Go to Firebase Console → Authentication
2. Enable Sign-in methods:
   - **Google** (required)
3. Configure OAuth consent screen
4. Add authorized domains

### 5. Get Web Client ID

1. Firebase Console → Project Settings → General
2. Scroll to "Your apps" → Web apps
3. Copy the Web Client ID
4. Add to `.env` file as `GOOGLE_WEB_CLIENT_ID`

### 6. Configure SHA-1 (Android)

For Google Sign-In to work on Android:

```bash
# Get debug SHA-1
cd android
./gradlew signingReport

# Add the SHA-1 to Firebase Console → Project Settings → Your apps → Android app
```

## 🏗️ Building the Project

### Debug Build

```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run with hot reload
flutter run --hot
```

### Release Build

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS
```bash
flutter build ios --release
# Then open in Xcode for signing and submission
```

### Clean Build

If you encounter build issues:

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## 🏛️ Project Architecture

Medico24 follows a **feature-based architecture** with separation of concerns:

```
lib/
├── core/              # Shared utilities and infrastructure
│   ├── database/      # Drift database and tables
│   ├── router/        # GoRouter navigation
│   ├── services/      # Business logic services
│   └── theme/         # App theme and colors
└── presentation/      # UI layer organized by feature
    ├── accessibility/ # Accessibility settings
    ├── auth/          # Authentication screens
    ├── home/          # Main home screen
    ├── location/      # Location management
    ├── profile/       # User profile
    └── splash/        # Splash screen
```

### Key Principles

1. **Separation of Concerns**: UI, business logic, and data layers are separated
2. **Feature-based Structure**: Related files are grouped by feature
3. **Dependency Injection**: Services are initialized at app level
4. **State Management**: StatefulWidget with local state for simple cases
5. **Database-first**: Drift for type-safe database operations

## 📝 Code Style Guidelines

### Dart Code Style

Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style):

```dart
// ✅ Good
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  
  @override
  State<UserProfile> createState() => _UserProfileState();
}

// ❌ Bad
class userProfile extends StatefulWidget {
  userProfile();  // Non-const constructor
}
```

### File Naming

- Dart files: `snake_case.dart`
- Classes: `PascalCase`
- Constants: `camelCase` (non-static) or `UPPER_CASE` (static final)
- Private members: `_prefixWithUnderscore`

### Formatting

Use `dart format` to auto-format code:

```bash
# Format all files
dart format .

# Format specific file
dart format lib/main.dart
```

### Import Organization

```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports (alphabetical)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

// 4. Relative imports
import '../../core/theme/app_colors.dart';
import '../services/auth_service.dart';
```

### Widget Structure

```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({super.key, required this.title});
  
  // 2. Fields
  final String title;
  
  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 4. Private helper methods
  Widget _buildHeader() {
    return Text(title);
  }
}
```

## 🗄️ Database Migrations

When modifying database schema:

### 1. Update Table Definitions

Edit `lib/core/database/tables.dart`:

```dart
class NewTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  // Add new columns here
}
```

### 2. Update Database Class

Edit `lib/core/database/database.dart`:

```dart
@DriftDatabase(tables: [AccessibilitySettings, SavedAddresses, NewTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 2;  // Increment version
  
  // Add migration logic if needed
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(newTable);
      }
    },
  );
}
```

### 3. Regenerate Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Test Migration

- Uninstall the app to clear old database
- Reinstall and verify schema

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Widget Tests

```dart
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  expect(find.text('0'), findsOneWidget);
});
```

## ❓ Common Issues

### Issue: Build Runner Conflicts

**Solution:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Firebase Authentication Errors

**Solution:**
- Verify `google-services.json` is in `android/app/`
- Check SHA-1 is added to Firebase Console
- Ensure `GOOGLE_WEB_CLIENT_ID` is correct in `.env`
- Clean and rebuild: `flutter clean && flutter run`

### Issue: Google Sign-In Not Working

**Solution:**
```bash
# 1. Get debug SHA-1
cd android
./gradlew signingReport

# 2. Add to Firebase Console
# 3. Re-download google-services.json
# 4. Clean build
flutter clean
flutter pub get
flutter run
```

### Issue: Drift Database Errors

**Solution:**
```bash
# Delete generated files and rebuild
find . -name "*.g.dart" -delete
dart run build_runner build
```

### Issue: Permission Denied (Location)

**Solution:**
- Check `AndroidManifest.xml` has location permissions
- Request permissions at runtime using `permission_handler`
- Test on physical device (some emulators don't support location)

## 🔍 Development Tips

1. **Hot Reload**: Press `r` in terminal during `flutter run` for instant UI updates
2. **Hot Restart**: Press `R` for full app restart with state reset
3. **DevTools**: Run `flutter pub global activate devtools` and `flutter pub global run devtools`
4. **Logging**: Use `debugPrint()` instead of `print()` for better performance
5. **Performance**: Use `const` constructors wherever possible

## 📞 Getting Help

- Check existing issues in the issue tracker
- Review Flutter documentation: https://docs.flutter.dev/
- Firebase documentation: https://firebase.google.com/docs
- Drift documentation: https://drift.simonbinder.eu/

## 🤝 Pull Request Process

1. Create a feature branch: `git checkout -b feature/your-feature-name`
2. Make your changes following code style guidelines
3. Format code: `dart format .`
4. Run tests: `flutter test`
5. Commit with descriptive messages
6. Push and create a pull request
7. Wait for code review

---

**Happy Coding! 🚀**

For questions or support, contact the development team.
