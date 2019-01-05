import 'dart:async';

bool _validate(String phone) {
  RegExp regex = RegExp(r"(\+62)?[0-9]+$");
  return regex.hasMatch(phone);
}

mixin FormatPhoneValidator {
  String validatePhoneNumber(String phone) {
    if (_validate(phone)) {
      return '';
    }
    return 'Invalid format phone (ex: +62xx / 08xxx)';
  }
}

mixin FormatPhoneValidatorStream {
  var validatePhoneNumberStream =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String phone, EventSink<String> sink) {
      if (_validate(phone)) {
        sink.add(phone);
      } else {
        sink.addError('Invalid format phone (ex: +62xx / 08xxx)');
      }
    },
  );
}
