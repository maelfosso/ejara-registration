import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {

  const RegisterResponse({
    this.responseCode = '',
    this.message = ''
  });

  final String responseCode;
  final String message;

  @override
  List<Object?> get props => [responseCode, message];

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      responseCode: json['responsecode'],
      message: json['message'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'message': message,
    };
  }
}