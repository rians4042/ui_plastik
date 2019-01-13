import 'package:dio/dio.dart';
import 'package:Recet/cache/user.dart';

Dio client(UserCache _user) {
  String baseUrl = 'http://128.199.182.237:3000/api/v1';
  if (_user != null && _user.getCompanyId() != null) {
    baseUrl = '$baseUrl/company/${_user.getCompanyId()}';
  }

  Dio _client = Dio(
    Options(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10).inMilliseconds,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "client_secret": "plastik"
      },
      responseType: ResponseType.JSON,
    ),
  );
  return _client;
}
