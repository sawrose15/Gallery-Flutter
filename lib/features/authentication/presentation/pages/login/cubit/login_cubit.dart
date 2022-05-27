import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_gallery/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/login_usecase.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/form_inputs/email_input.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/form_inputs/password_input.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUsecase)
      : super(const LoginState.loginWithEmailAndPassword());

  final LoginUsecase _loginUsecase;

  void onLoginPressed() {
    state.whenOrNull(
        loginWithEmailAndPassword: (status, email, password, message) async {
      emit(state.copyWith(status: Formz.validate([email, password])));
      if (status.isValidated) {
        emit(state.copyWith(status: FormzStatus.submissionInProgress));
        final result = await _loginUsecase.execute(UserParams(
          email.value,
          password.value,
        ));
        result.fold((l) async {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure, message: l.toString()));
        }, (r) async {
          emit(state.copyWith(
            status: FormzStatus.submissionSuccess,
          ));
        });
      }
    });
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    dynamic password = state.whenOrNull(
          loginWithEmailAndPassword: (status, email, password, message) =>
              password,
        ) ??
        const Password.pure();
    emit(LoginState.loginWithEmailAndPassword(
        email: email,
        password: password,
        status: Formz.validate([email, password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    dynamic email = state.whenOrNull(
          loginWithEmailAndPassword: (status, email, password, message) =>
              email,
        ) ??
        const Email.pure();

    emit(LoginState.loginWithEmailAndPassword(
        email: email,
        password: password,
        status: Formz.validate([email, password])));
  }
}
