import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/features/authentication/domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUsecase) : super(LoginState());

  final LoginUsecase _loginUsecase;
}
