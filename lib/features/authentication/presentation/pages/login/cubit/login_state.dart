part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.loginWithEmailAndPassword({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(Email.pure()) Email email,
    @Default(Password.pure()) Password password,
    String? message,
  }) = _LoginWithEmailAndPassword;
}
