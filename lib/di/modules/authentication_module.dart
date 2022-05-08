import 'package:authentication_repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthenticationModule {
  @lazySingleton
  AuthenticationRepository get authenticationRepository =>
      AuthenticationRepository();
}
