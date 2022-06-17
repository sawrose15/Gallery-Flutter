import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/di/di.dart';
import 'package:photo_gallery/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:photo_gallery/utils/app_route.gr.dart';

@injectable
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authentication = getIt<AuthenticationBloc>();
    authentication.state.map(
      initial: (_) => {debugPrint('initial'), null},
      unauthenticated: (_) => {
        debugPrint('UnAuthenticated State'),
        router.push(const LoginRoute())
      },
      authenticated: (user) =>
          {debugPrint('Authenticated State'), resolver.next(true)},
    );
  }
}
