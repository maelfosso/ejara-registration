import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ejara/api/api.dart';
import 'package:ejara/api/responses/register_response.dart';
import 'package:ejara/models/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFailure implements Exception {
  String reason;
  int statusCode;

  RegisterFailure(this.reason, this.statusCode);
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({
    RestClient? api
  }) :  _api = api ?? APIs.getRestClient() ;

  final RestClient _api;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  User get user {
    return User.empty;
  }

  Future<User> get currentUser async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = prefs.getString(userCacheKey);

    return res == null
      ? User.empty
      : User.fromJson(json.decode(res))
    ;
  }

  Future<RegisterResponse?> register({ 
    required String username, 
    required String email, 
    required String phoneNumber,
    required String country
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    RegisterResponse response;
    try {
      response = await _api.register(username, email, phoneNumber, country);
      
      return response;
    } on Exception catch (e) {      
      switch (e.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (e as DioError).response;
          Map<String, dynamic> dataMsg = json.decode(json.encode(res?.data));

          throw new RegisterFailure(dataMsg["message"]!.toString(), res?.statusCode ?? 400);
        default:
      }
    }

  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userCacheKey);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    
  }
}