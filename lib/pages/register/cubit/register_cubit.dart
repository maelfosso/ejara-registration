import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ejara/models/country.dart';
import 'package:ejara/pages/fields/email.dart';
import 'package:ejara/pages/fields/phone_number.dart';
import 'package:ejara/pages/fields/username.dart';
import 'package:ejara/repositories/authentication/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authenticationRepository) : super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.email,
        state.phoneNumber,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.username,
        state.phoneNumber,
      ]),
    ));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.username,
        phoneNumber,
      ]),
    ));
  }

  void countryChanged(CountryCode countryCode) {
    print("COUNTRY CAHNANGED ${countryCode.code} - ${countryCode.dialCode} - ${countryCode.flagUri} - ${countryCode.name}");
    print(Country.fromCountryCode(countryCode));
    emit(state.copyWith(
      country: Country.fromCountryCode(countryCode))
    );
  }

  Future<void> registerFormSubmitted() async {
    print('RegisterSubmitted : ${state.username.value} - ${state.phoneNumber.value}');
    print('RegisterFormStatus : ${state.status.isValid}');
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final response = await _authenticationRepository.register(
        username: state.username.value,
        email: state.email.value,
        phoneNumber: state.phoneNumber.value,
        country: state.country.code!,
      );
      print('Response -- $response');
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {
      print('RegisterFormSubmitted : throw exception \n $e');
      String reason = '';
      if (e is RegisterFailure) {
        print("CUSTGOMER MESSAGE : ${e.reason}");
        reason = e.reason;
      }
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorReason: reason
      ));
    }
  }
}
