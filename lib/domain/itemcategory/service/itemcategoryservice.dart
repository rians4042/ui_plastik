import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plastik_ui/domain/itemcategory/api/itemcategoryapi.dart';
import 'package:plastik_ui/domain/itemcategory/model/itemcategorymodel.dart';

abstract class ItemCategoryServiceInterface {
  Future<List<ItemCategoryAPIModel>> getItemCategory();
}

class ItemCategoryService extends ItemCategoryServiceInterface {
  ItemCategoryAPIInterface api;

  ItemCategoryService({
    @required this.api,
  });

  @override
  Future<List<ItemCategoryAPIModel>> getItemCategory() async {
    final http.Response resp = await api.getItemCategory();
    if (resp?.body != null) {
      final body = jsonDecode(resp.body);
      List<ItemCategoryAPIModel> results = [];

      // make modelling
      for (int i = 0; i < body.length; i++) {
        final ItemCategoryAPIModel temp = ItemCategoryAPIModel(
          body: body[i]['body'],
          id: body[i]['id'],
          title: body[i]['title'],
          userId: body[i]['userId'],
        );

        results.add(temp);
      }

      return results;
    }
    return null;
  }
}
