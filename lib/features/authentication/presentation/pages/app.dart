import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/configs/app_theme.dart';
import 'package:photo_gallery/di/di.dart';
import 'package:photo_gallery/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:photo_gallery/utils/app_route.gr.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final _router = getIt<AppRoute>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      title: 'Photo Gallery',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerDelegate: _router.delegate(),
      routeInformationParser:
          _router.defaultRouteParser(includePrefixMatches: true),
      routeInformationProvider: _router.routeInfoProvider(),
      builder: (context, child) => BlocProvider(
        create: (context) => getIt<AuthenticationBloc>(),
        child: child,
      ),
    );
  }
}
