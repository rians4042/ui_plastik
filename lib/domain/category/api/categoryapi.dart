import 'package:http/http.dart' as http;

abstract class CategoryAPIInterface {
  Future<http.Response> getCategory();
}

class CategoryAPI extends CategoryAPIInterface {
  @override
  Future<http.Response> getCategory() async {
    final http.Response resp =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    return resp;
  }
}
