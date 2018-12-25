import 'package:http/http.dart' as http;

abstract class ItemAPIInterface {
  Future<http.Response> getItems();
}

class ItemAPI extends ItemAPIInterface {
  @override
  Future<http.Response> getItems() async {
    final http.Response resp = await http.get(
      'https://radiant-lake-16924.herokuapp.com/api/v1/itemcategory',
      headers: {
        'Content-Type': 'applicatioh/json',
        'Accept': 'applicatioh/json',
        'client_secret': 'plastik'
      },
    );
    return resp;
  }
}
