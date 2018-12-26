import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart' as Model;
import 'package:dio/dio.dart';
import 'package:plastik_ui/helpers/request/parser.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';

abstract class SupplierAPI {
  Future<bool> createSupplier(Model.SupplierAPI supplier);
  Future<bool> updateSupplier(String id, Model.SupplierAPI supplier);
  Future<List<Model.SupplierAPI>> getSuppliers();
  Future<Model.SupplierAPI> getSupplierDetail(String id);
  Future<bool> deleteSupplier(String id);
}

class SupplierAPIImplementation extends Object
    with ErrorHandler
    implements SupplierAPI {
  final Dio client;

  SupplierAPIImplementation({
    @required this.client,
  });

  @override
  Future<bool> createSupplier(Model.SupplierAPI supplier) async {
    final Response response = await client.post('suppliers', data: {
      'name': supplier.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<Model.SupplierAPI> getSupplierDetail(String id) async {
    final Response response = await client.get('sellers/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<Model.SupplierAPI, Map<String, dynamic>>(
        Model.SupplierAPI.fromJSON, response.data);
  }

  @override
  Future<List<Model.SupplierAPI>> getSuppliers() async {
    final Response response = await client.get('suppliers');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<Model.SupplierAPI>,
            List<Map<String, dynamic>>>(
        Model.SupplierAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSupplier(String id, Model.SupplierAPI supplier) async {
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
}
