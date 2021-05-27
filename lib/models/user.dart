import 'package:ejara/models/country.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {

  const User({
    this.username,
    this.email,
    this.phoneNumber,
    this.country = Country.empty
  });
  
  final String? username;
  final String? email;
  final String? phoneNumber;
  final Country? country;

  static const empty = User(
    username: '', 
    email: '', 
    phoneNumber: '', 
    country: Country.empty
  );

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [username, email, phoneNumber, country];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      country: Country.fromJson(json['country'])
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'country': country?.toJson()
    };
  }
}
