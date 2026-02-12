import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medico24/core/router/app_router.dart';
import 'package:medico24/core/service_locator.dart';
import 'package:medico24/core/services/notification_service.dart';
import 'package:medico24/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Warning: Could not load .env file: $e');
  }

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Firebase Cloud Messaging
  await NotificationService().initialize();

  // Initialize service locator
  serviceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Medico24',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.createRouter(),
    );
  }
}
