import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plastik_ui/domain/item/api/itemapi.dart';
import 'package:plastik_ui/domain/item/model/itemmodel.dart';

abstract class ItemServiceInterface {
  Future<List<ItemAPIModel>> getItems();
}

class ItemService extends ItemServiceInterface {
  ItemAPIInterface api;

  ItemService({
    @required this.api,
  });

  @override
  Future<List<ItemAPIModel>> getItems() async {
    final http.Response resp = await api.getItems();
    if (resp?.body != null) {
      final body = jsonDecode(resp.body);
      List<ItemAPIModel> results = [];

      // make modelling
      for (int i = 0; i < body.length; i++) {
        final ItemAPIModel temp = ItemAPIModel(
          name: body[i]['name'],
          id: body[i]['id'],
          createdaAt: body[i]['createdAt'],
        );
        results.add(temp);
      }

      return results;
    }
    return null;
  }
}
