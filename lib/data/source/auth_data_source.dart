
import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/auth_info.dart';
import 'package:project_seven_nike_welcomeback/data/comment/constanst.dart';
import 'package:project_seven_nike_welcomeback/data/common/http_response_validator.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);

  Future<AuthInfo> signUp(String username, String password);

  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);

  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });

    validateResponse(response);

    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"],username);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type" : "refresh_token",
      "refresh_token" : token,
      "client" : 2,
      "client_secret" : Constants.clientSecret
    });

    validateResponse(response);

    return AuthInfo(response.data["access_token"], response.data["refresh_token"], '');
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final response = await  httpClient
        .post("user/register", data: {"email": username, "password": password});

    validateResponse(response);

    return login(username, password);
  }
}
