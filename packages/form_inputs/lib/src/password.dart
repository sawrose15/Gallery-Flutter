
import 'package:formz/formz.dart';

/// Validation Error for [Password] [FormzInput]
enum PasswordValidationError{
  ///Generic Error.
  invalid
}

class Password extends FormzInput<String, PasswordValidationError>{

  /// {@macro password}
  const Password.pure(): super.pure('');

  /// {@macro password}
  const Password.dirty([String value = '']): super.dirty(value);

  static final _passwordRegExp =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');


  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }

}