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
    final Response response = await client.post('/seller', data: {
      'name': seller.name,
      'phone': seller.phone,
      'address': seller.address,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<model.SellerAPI> getSellerDetail(String id) async {
    final Response response = await client.get('/seller/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<model.SellerAPI, dynamic>(
        model.SellerAPI.fromJSON, response.data);
  }

  @override
  Future<List<model.SellerAPI>> getSellers() async {
    final Response response = await client.get('/seller');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.SellerAPI>, List<dynamic>>(
        model.SellerAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSeller(String id, model.SellerAPI seller) async {
    final Response response = await client.patch('/seller/$id', data: {
      'name': seller.name,
      'phone': seller.phone,
      'address': seller.address,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteSeller(String id) async {
    final Response response = await client.delete('/seller/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }
}
