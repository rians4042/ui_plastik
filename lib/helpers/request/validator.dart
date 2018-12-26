import 'package:dio/dio.dart';

void scanErrorRequest(Response response) {
  if (response.statusCode >= 400) {
    throw response?.data['messages'] ?? 'Terjadi Kesalahan Pada Server';
  }
}
