import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medico24/presentation/auth/login_screen.dart';
import 'package:medico24/presentation/home/home_screen.dart';
import 'package:medico24/presentation/location/add_address_screen.dart';
import 'package:medico24/presentation/location/location_selection_screen.dart';
import 'package:medico24/presentation/profile/profile_screen.dart';
import 'package:medico24/presentation/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String locationSelection = '/location-selection';
  static const String addAddress = '/add-address';
  static const String profile = '/profile';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: splash,
      routes: [
        GoRoute(
          path: splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(path: login, builder: (context, state) => const LoginScreen()),
        GoRoute(path: home, builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: locationSelection,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const LocationSelectionScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        ),
        GoRoute(
          path: addAddress,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: const AddAddressScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        ),
      ],
    );
  }
}
