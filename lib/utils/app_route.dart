import 'package:flutter/material.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/login/views/login_page.dart';
import 'package:photo_gallery/features/home/presentation/pages/home_page.dart';

abstract class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const photoOverview = '/photo_overview';
  static const photoDetail = '/photo_detail';
  static const shared = '/shared';
}

class AppRouter {
  Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
