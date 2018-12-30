import 'package:dio/dio.dart';
import 'package:plastik_ui/cache/user.dart';

Dio client(UserCache _user) {
  String baseUrl = 'https://radiant-lake-16924.herokuapp.com/api/v1';
  if (null != _user.getCompanyId()) {
    baseUrl = '$baseUrl/company/${_user.getCompanyId()}';
  }

  Dio _client = Dio(
    Options(
      baseUrl: baseUrl,
      connectTimeout: Duration(minutes: 1).inMilliseconds,
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