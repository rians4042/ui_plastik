import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';
import 'package:plastik_ui/domains/item/model/api/item-unit.dart' as model;
import 'package:plastik_ui/helpers/request/parser.dart';

abstract class ItemUnitAPI {
  Future<List<model.ItemUnitAPI>> getItemUnits();
}

class ItemUnit extends Object with ErrorHandler implements ItemUnitAPI {
  Dio client;

  ItemUnit({@required this.client});

  @override
  Future<List<model.ItemUnitAPI>> getItemUnits() async {
    final Response response = await client.get('item-unit');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.ItemUnitAPI>,
            List<Map<String, dynamic>>>(
        model.ItemUnitAPI.fromListJSON, response.data);
  }
}
