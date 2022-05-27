import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties = const <dynamic>[];
  const Failure([properties]);

  @override
  List<Object?> get props => [properties];
}

class RegisterFailure extends Failure {}

class LoginFailure extends Failure {}

class LogoutFailure extends Failure {}

class CheckAuthenticationFailure extends Failure {}

class ConnectionFailure extends Failure {}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure(this.message) : super(message);
}
