import 'package:formz/formz.dart';

enum SearchValidationError{
  //generic error
  invalid
}

class Search extends FormzInput<String, SearchValidationError>{
  /// {@macro email}
  const Search.pure(): super.pure('');

  /// {@macro email}
  const Search.dirty([String value = '']): super.dirty(value);

  static final RegExp _searchRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  SearchValidationError? validator(String value) {
   return _searchRegExp.hasMatch(value ?? '')
       ? null
       : SearchValidationError.invalid;
  }

}