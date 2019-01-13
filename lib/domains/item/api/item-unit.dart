import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:Recet/helpers/request/error-handler.dart';
import 'package:Recet/domains/item/model/api/item-unit.dart' as model;
import 'package:Recet/helpers/request/parser.dart';

abstract class ItemUnitAPI {
  Future<List<model.ItemUnitAPI>> getItemUnits();
}

class ItemUnitAPIImplementation extends Object
    with ErrorHandler
    implements ItemUnitAPI {
  Dio client;

  ItemUnitAPIImplementation({@required this.client});

  @override
  Future<List<model.ItemUnitAPI>> getItemUnits() async {
    final Response response = await client.get('/item-unit');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.ItemUnitAPI>, List<dynamic>>(
        model.ItemUnitAPI.fromListJSON, response.data);
  }
}
