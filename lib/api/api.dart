import 'package:dio/dio.dart';
import 'package:ejara/api/responses/register_response.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

class APIs {
  static const String register = "/api/v1/auth/sign-up/check-signup-details";

  static RestClient? _restClient;

  static RestClient getRestClient() {
    if (_restClient == null) {
      _restClient = RestClient(Dio());
    }

    return _restClient!;
  }
}

@RestApi(baseUrl: "https://sandbox.nellys-coin.ejaraapis.xyz")
abstract class RestClient {
  factory RestClient(Dio dio, { String baseUrl }) = _RestClient;

  @POST(APIs.register)
  Future<RegisterResponse> register(
    @Field() String username,
    @Field("email_address") String email,
    @Field("phone_number") String phoneNumber,
    @Field("country_code") String country
  );

}