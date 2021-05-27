
import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9_]{3,30}$'
  );

  @override
  validator(String value) {
    return value.isEmpty || !_usernameRegExp.hasMatch(value) || value == 'ejara'
      ? UsernameValidationError.invalid
      : null
    ;
  }
}