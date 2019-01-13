import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:Recet/domains/item/model/api/item-category.dart' as model;
import 'package:Recet/helpers/request/error-handler.dart';
import 'package:Recet/helpers/request/parser.dart';

abstract class ItemCategoryAPI {
  Future<List<model.ItemCategoryAPI>> getCategories();
  Future<model.ItemCategoryAPI> getCategoryDetail(String id);
  Future<bool> createCategory(model.ItemCategoryAPI itemCategory);
  Future<bool> updateCategory(String id, model.ItemCategoryAPI itemCategory);
  Future<bool> deleteCategory(String id);
}

class ItemCategoryAPIImplementation extends Object
    with ErrorHandler
    implements ItemCategoryAPI {
  Dio client;

  ItemCategoryAPIImplementation({@required this.client});

  @override
  Future<bool> createCategory(model.ItemCategoryAPI itemCategory) async {
    final Response response = await client.post('/item-category', data: {
      'name': itemCategory.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteCategory(String id) async {
    final Response response = await client.delete('/item-category/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<List<model.ItemCategoryAPI>> getCategories() async {
    final Response response = await client.get('/item-category');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.ItemCategoryAPI>, List<dynamic>>(
        model.ItemCategoryAPI.fromListJSON, response.data);
  }

  @override
  Future<model.ItemCategoryAPI> getCategoryDetail(String id) async {
    final Response response = await client.get('/item-category/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<model.ItemCategoryAPI, dynamic>(
        model.ItemCategoryAPI.fromJSON, response.data);
  }

  @override
  Future<bool> updateCategory(
      String id, model.ItemCategoryAPI itemCategory) async {
    final Response response = await client.patch('/item-category/$id', data: {
      'name': itemCategory.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }
}
