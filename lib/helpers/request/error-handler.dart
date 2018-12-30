import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class ErrorMessage extends Error {
  final String message;
  final String code;
  final String statusText;
  final List<String> fields;

  ErrorMessage({
    @required this.message,
    @required this.code,
    @required this.statusText,
    @required this.fields,
  });
}

mixin ErrorHandler {
  void throwErrorIfErrorFounded(Response response) {
    if (response.statusCode >= 400) {
      if (response.data is Map) {
        throw ErrorMessage(
          code: (response.data as Map).containsKey('code')
              ? response.data['code']
              : '',
          message: (response.data as Map).containsKey('message')
              ? response.data['message']
              : '',
          statusText: (response.data as Map).containsKey('statusText')
              ? response.data['statusText']
              : '',
          fields: (response.data as Map).containsKey('fields')
              ? response.data['fields']
              : '',
        );
      } else if (response.data is String) {
        throw ErrorMessage(
          code: '',
          message: response.data,
          statusText: '',
          fields: [],
        );
      }
    }
  }
}
