import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class RegisterResponse extends Equatable {

  const RegisterResponse({
    this.responseCode = '',
    this.message = '',
    this.statusCode = 200
  });

  final String responseCode;
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [responseCode, message];

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      responseCode: json['responsecode'],
      message: json['message'],
      statusCode: json['statusCode']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'message': message,
      'statusCode': statusCode
    };
  }
}