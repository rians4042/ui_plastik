import 'package:dio/dio.dart';

mixin ErrorHandler {
  void throwErrorIfErrorFounded(Response response) {
    if (response.statusCode >= 400) {
      throw response?.data['messages'] ?? 'Terjadi Kesalahan Pada Server';
    }
  }
}
