// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../features/authentication/presentation/pages/login/login.dart' as _i1;
import '../features/authentication/presentation/pages/register/register.dart'
    as _i2;
import '../features/home/presentation/pages/home_page.dart' as _i3;
import '../features/photo_overview_list/presentation/pages/photo_overview_page.dart'
    as _i6;
import '../features/shared/presentation/pages/shared_page.dart' as _i5;
import 'app_route.dart' as _i4;
import 'AuthGuard.dart' as _i9;

class AppRoute extends _i7.RootStackRouter {
  AppRoute(
      {_i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i9.AuthGuard authGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.RegisterPage());
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    PhotoFullRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyPageRoute());
    },
    SharedRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.SharedPage());
    },
    PhotoOverview.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.PhotoOverviewPage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(LoginRoute.name, path: '/login'),
        _i7.RouteConfig(RegisterRoute.name, path: '/register'),
        _i7.RouteConfig(HomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i7.RouteConfig(PhotoFullRoute.name,
              path: 'photoFullRoute',
              parent: HomeRoute.name,
              children: [
                _i7.RouteConfig(PhotoOverview.name,
                    path: '', parent: PhotoFullRoute.name)
              ]),
          _i7.RouteConfig(SharedRoute.name,
              path: 'shared', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.EmptyPageRoute]
class PhotoFullRoute extends _i7.PageRouteInfo<void> {
  const PhotoFullRoute({List<_i7.PageRouteInfo>? children})
      : super(PhotoFullRoute.name,
            path: 'photoFullRoute', initialChildren: children);

  static const String name = 'PhotoFullRoute';
}

/// generated route for
/// [_i5.SharedPage]
class SharedRoute extends _i7.PageRouteInfo<void> {
  const SharedRoute() : super(SharedRoute.name, path: 'shared');

  static const String name = 'SharedRoute';
}

/// generated route for
/// [_i6.PhotoOverviewPage]
class PhotoOverview extends _i7.PageRouteInfo<void> {
  const PhotoOverview() : super(PhotoOverview.name, path: '');

  static const String name = 'PhotoOverview';
}
