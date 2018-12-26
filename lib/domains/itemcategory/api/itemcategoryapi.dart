import 'package:http/http.dart' as http;

abstract class ItemCategoryAPIInterface {
  Future<http.Response> getItemCategory();
}

class ItemCategoryAPI extends ItemCategoryAPIInterface {
  @override
  Future<http.Response> getItemCategory() async {
    final http.Response resp =
        await http.get('https://jsonplaceholder.typicode.com/posts');
    return resp;
  }
}
