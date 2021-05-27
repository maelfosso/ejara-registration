part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
    this.country = Country.empty,
    this.errorReason = ''
  });

  final Username username;
  final Email email;
  final PhoneNumber phoneNumber;
  final FormzStatus status;
  final Country country;
  final String? errorReason;

  @override
  List<Object> get props => [username, email, phoneNumber, country, status];

  RegisterState copyWith({
    Username? username,
    Email? email,
    PhoneNumber? phoneNumber,
    FormzStatus? status,
    Country? country,
    String? errorReason
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      status: status ?? this.status,
      errorReason: errorReason ?? this.errorReason
    );
  }
}
