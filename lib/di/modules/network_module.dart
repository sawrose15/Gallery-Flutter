import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photo_gallery/utils/AuthGuard.dart';
import 'package:photo_gallery/utils/app_route.gr.dart';

@module
abstract class NetworkInfo {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @lazySingleton
  AppRoute get router => AppRoute(authGuard: AuthGuard());
}
