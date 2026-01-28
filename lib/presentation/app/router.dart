import 'package:aplyflow/presentation/pages/auth/auth_page.dart';
// import 'package:aplyflow/presentation/screen/splash/splash_screen.dart';
import 'package:aplyflow/presentation/screens/splash/splash_screen.dart';
import 'package:aplyflow/presentation/screens/starter/starter_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const splash = '/';
  static const auth = '/auth';
  static const starter = '/starter';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
