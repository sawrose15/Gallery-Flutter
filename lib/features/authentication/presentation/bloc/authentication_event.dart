part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.checkAuthentication() =
      _CheckAuthentication;
  const factory AuthenticationEvent.loginWithEmailAndPassword({
    required String email,
    required String password,
  }) = _LoginWithEmailAndPassword;
  const factory AuthenticationEvent.registerWithEmailAndPassword({
    required String email,
    required String password,
  }) = _RegisterWithEmailAndPassword;
  const factory AuthenticationEvent.loggedOut() = _LoggedOut;
}
