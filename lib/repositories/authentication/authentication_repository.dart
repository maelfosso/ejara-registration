import 'dart:async';
import 'dart:convert';

import 'package:ejara/api/api.dart';
import 'package:ejara/models/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFailure implements Exception {}

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

  Future<void> register({ 
    required String username, 
    required String email, 
    required String phoneNumber,
    required String country
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    try {
      final response = await _api.register(username, email, phoneNumber, country);
      
      prefs.setString(userCacheKey, json.encode(response));
      _controller.add(AuthenticationStatus.authenticated);
    } on Exception catch (e) {
      print('API Sign up throw execption');
      print(e);
      throw RegisterFailure();
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