import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _PhoneNumberRegExp = 
    RegExp(r'^\+\d{1,}$');

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _PhoneNumberRegExp.hasMatch(value ?? '')
      ? null 
      : PhoneNumberValidationError.invalid
    ;
  }
}