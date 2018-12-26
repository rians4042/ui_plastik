import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/api/seller.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:dio/dio.dart';
import 'package:plastik_ui/helpers/request/parser.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';

abstract class ActorAPI {
  Future<bool> createSupplier(SupplierAPI supplier);
  Future<bool> updateSupplier(String id, SupplierAPI supplier);
  Future<List<SupplierAPI>> getSuppliers();
  Future<SupplierAPI> getSupplierDetail(String id);
  Future<bool> createSeller(SellerAPI seller);
  Future<bool> updateSeller(String id, SellerAPI seller);
  Future<List<SellerAPI>> getSellers();
  Future<SellerAPI> getSellerDetail(String id);
  Future<bool> deleteSupplier(String id);
  Future<bool> deleteSeller(String id);
}

class ActorAPIImplementation extends Object
    with ErrorHandler
    implements ActorAPI {
  final Dio client;

  ActorAPIImplementation({
    @required this.client,
  });

  @override
  Future<bool> createSeller(SellerAPI seller) async {
    final Response response = await client.post('sellers', data: {
      'name': seller.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> createSupplier(SupplierAPI supplier) async {
    final Response response = await client.post('suppliers', data: {
      'name': supplier.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<SellerAPI> getSellerDetail(String id) async {
    final Response response = await client.get('sellers/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<SellerAPI, Map<String, dynamic>>(
        SellerAPI.fromJSON, response.data);
  }

  @override
  Future<List<SellerAPI>> getSellers() async {
    final Response response = await client.get('sellers');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<SellerAPI>, List<Map<String, dynamic>>>(
        SellerAPI.fromListJSON, response.data);
  }

  @override
  Future<SupplierAPI> getSupplierDetail(String id) async {
    final Response response = await client.get('sellers/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<SupplierAPI, Map<String, dynamic>>(
        SupplierAPI.fromJSON, response.data);
  }

  @override
  Future<List<SupplierAPI>> getSuppliers() async {
    final Response response = await client.get('suppliers');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<SupplierAPI>, List<Map<String, dynamic>>>(
        SupplierAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSeller(String id, SellerAPI seller) async {
    final Response response = await client.patch('sellers', data: {
      'name': seller.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> updateSupplier(String id, SupplierAPI supplier) async {
    final Response response = await client.patch('suppliers', data: {
      'name': supplier.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteSupplier(String id) async {
    final Response response = await client.delete('suppliers/$id');
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
