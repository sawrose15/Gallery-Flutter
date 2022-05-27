import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:photo_gallery/features/core/data/datasources/cache.dart';

@module
abstract class NetworkInfo {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();
  @lazySingleton
  Cache get cache => Cache.init();
}
