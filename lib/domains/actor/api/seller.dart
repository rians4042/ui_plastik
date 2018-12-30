import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/api/seller.dart' as model;
import 'package:dio/dio.dart';
import 'package:plastik_ui/helpers/request/parser.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';

abstract class SellerAPI {
  Future<bool> createSeller(model.SellerAPI seller);
  Future<bool> updateSeller(String id, model.SellerAPI seller);
  Future<List<model.SellerAPI>> getSellers();
  Future<model.SellerAPI> getSellerDetail(String id);
  Future<bool> deleteSeller(String id);
}

class SellerAPIImplementation extends Object
    with ErrorHandler
    implements SellerAPI {
  final Dio client;

  SellerAPIImplementation({
    @required this.client,
  });

  @override
  Future<bool> createSeller(model.SellerAPI seller) async {
    final Response response = await client.post('sellers', data: {
      'name': seller.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<model.SellerAPI> getSellerDetail(String id) async {
    final Response response = await client.get('sellers/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<model.SellerAPI, Map<String, dynamic>>(
        model.SellerAPI.fromJSON, response.data);
  }

  @override
  Future<List<model.SellerAPI>> getSellers() async {
    final Response response = await client.get('sellers');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.SellerAPI>, List<Map<String, dynamic>>>(
        model.SellerAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSeller(String id, model.SellerAPI seller) async {
    final Response response = await client.patch('sellers', data: {
      'name': seller.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteSeller(String id) async {
    final Response response = await client.delete('sellers/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }
}