import 'package:http/http.dart' as http;

abstract class TransactionAPIInterface {
  Future<http.Response> getTransaction();
}

class TransactionAPI extends TransactionAPIInterface {
  @override
  Future<http.Response> getTransaction() async {
    final http.Response response = await http.get('heroku');
    return response;
  }
}
