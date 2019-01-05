import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:plastik_ui/domains/item/model/api/item.dart' as model;
import 'package:plastik_ui/helpers/request/error-handler.dart';
import 'package:plastik_ui/helpers/request/parser.dart';

abstract class ItemAPI {
  Future<List<model.ItemAPI>> getItems();
  Future<model.ItemAPI> getItemDetail(String id);
  Future<bool> createItem(model.ItemAPI itemCategory);
  Future<bool> updateItem(String id, model.ItemAPI itemCategory);
  Future<bool> deleteItem(String id);
}

class ItemAPIImplementation extends Object
    with ErrorHandler
    implements ItemAPI {
  Dio client;

  ItemAPIImplementation({@required this.client});

  @override
  Future<bool> createItem(model.ItemAPI item) async {
    final Response response = await client.post('/item', data: {
      'name': item.name,
      'itemCategoryId': item.itemCategoryId,
      'unitId': item.unitId,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteItem(String id) async {
    final Response response = await client.delete('/item/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<List<model.ItemAPI>> getItems() async {
    final Response response = await client.get('/item');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.ItemAPI>, List<dynamic>>(
        model.ItemAPI.fromListJSON, response.data);
  }

  @override
  Future<model.ItemAPI> getItemDetail(String id) async {
    final Response response = await client.get('/item/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<model.ItemAPI, dynamic>(
        model.ItemAPI.fromJSON, response.data);
  }

  @override
  Future<bool> updateItem(String id, model.ItemAPI item) async {
    final Response response = await client.patch('/item/$id', data: {
      'name': item.name,
      'itemCategoryId': item.itemCategoryId,
      'unitId': item.unitId,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }
}
