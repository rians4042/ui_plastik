import 'package:dio/dio.dart';
import 'package:plastik_ui/cache/user.dart';

Dio client(UserCache _user) {
  String baseUrl = 'http://cadbe466.ngrok.io/api/v1';
  if (null != _user.getCompanyId()) {
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
