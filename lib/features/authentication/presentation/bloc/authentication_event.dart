part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AuthenticationEvent {}

class CheckAuthentication extends AuthenticationEvent {
  const CheckAuthentication() : super();
}

class LoginWithEmailAndPassword extends AuthenticationEvent {
  const LoginWithEmailAndPassword(this.userParams);

  final UserParams userParams;

  @override
  List<Object> get props => [userParams];
}

class RegisterWithEmailAndPassword extends AuthenticationEvent {
  const RegisterWithEmailAndPassword(this.userParams);

  final UserParams userParams;

  @override
  List<Object> get props => [userParams];
}
