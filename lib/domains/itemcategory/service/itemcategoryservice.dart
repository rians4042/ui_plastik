import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plastik_ui/domain/itemcategory/api/itemcategoryapi.dart';
import 'package:plastik_ui/domain/itemcategory/model/itemcategoryapimodel.dart';

abstract class ItemCategoryServiceInterface {
  Future<List<ItemCategoryAPIModel>> getItemCategories();
}

class ItemCategoryService extends ItemCategoryServiceInterface {
  ItemCategoryAPIInterface api;

  ItemCategoryService({
    @required this.api,
  });

  @override
  Future<List<ItemCategoryAPIModel>> getItemCategories() async {
    final http.Response resp = await api.getItemCategories();
    if (resp?.body != null) {
      final body = jsonDecode(resp.body);
      List<ItemCategoryAPIModel> results = [];

      // make modelling
      for (int i = 0; i < body.length; i++) {
        final ItemCategoryAPIModel temp = ItemCategoryAPIModel(
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
