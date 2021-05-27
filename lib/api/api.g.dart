// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://sandbox.nellys-coin.ejaraapis.xyz';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<RegisterOKResponse> register(
      username, email, phoneNumber, country) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'username': username,
      'email_address': email,
      'phone_number': phoneNumber,
      'country_code': country
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterOKResponse>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, '/api/v1/auth/sign-up/check-signup-details',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterOKResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
