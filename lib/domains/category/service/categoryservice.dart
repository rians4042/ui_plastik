import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:plastik_ui/domain/category/api/categoryapi.dart';
import 'package:plastik_ui/domain/category/mode/categorymodel.dart';

abstract class CategoryServiceInterface {
  Future<List<CategoryAPIModel>> getCategory();
}

class CategoryService extends CategoryServiceInterface {
  CategoryAPIInterface api;

  CategoryService({
    @required this.api,
  });

  @override
  Future<List<CategoryAPIModel>> getCategory() async {
    final http.Response resp = await api.getCategory();
    if (resp?.body != null) {
      final body = jsonDecode(resp.body);
      List<CategoryAPIModel> results = [];

      // make modelling
      for (int i = 0; i < body.length; i++) {
        final CategoryAPIModel temp = CategoryAPIModel(
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
