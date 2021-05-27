part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final Username username;
  final Email email;
  final PhoneNumber phoneNumber;
  final FormzStatus status;

  @override
  List<Object> get props => [username, email, phoneNumber, status];

  RegisterState copyWith({
    Username? username,
    Email? email,
    PhoneNumber? phoneNumber,
    FormzStatus? status,
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }
}
