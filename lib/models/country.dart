import 'package:country_code_picker/country_code.dart';
import 'package:equatable/equatable.dart';

class Country extends Equatable {

  const Country({
    this.name = '',
    this.code = ''
  });
  
  final String name;
  final String code;

  static const empty = Country(name: '', code: '');

  bool get isEmpty => this == Country.empty;

  bool get isNotEmpty => this != Country.empty;

  @override
  List<Object?> get props => [name, code];

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code']
    );
  }

  factory Country.fromCountryCode(CountryCode countryCode) {
    return Country(
      name: countryCode.dialCode!,
      code: countryCode.code!
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code
    };
  }
}