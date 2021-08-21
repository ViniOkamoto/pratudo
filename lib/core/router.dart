import 'package:flutter/material.dart';
import 'package:pratudo/core/resources/routes.dart';
import 'package:pratudo/features/screens/login/login_page.dart';
import 'package:pratudo/features/screens/register/register_page.dart';
import 'package:pratudo/features/screens/splash/splash_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage(), settings: settings);
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage(), settings: settings);
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterPage(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
