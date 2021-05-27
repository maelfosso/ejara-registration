import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class RegisterOKResponse extends Equatable {

  const RegisterOKResponse({
    this.responseCode = '',
    this.message = ''
  });

  final String responseCode;
  final String message;

  @override
  List<Object?> get props => [responseCode, message];

  factory RegisterOKResponse.fromJson(Map<String, dynamic> json) {
    return RegisterOKResponse(
      responseCode: json['responseCode'],
      message: json['message']
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'message': message
    };
  }
}