import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:Recet/domains/actor/model/api/supplier.dart' as Model;
import 'package:dio/dio.dart';
import 'package:Recet/helpers/request/parser.dart';
import 'package:Recet/helpers/request/error-handler.dart';

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
    final Response response = await client.post(
      '/supplier',
      data: {
        'name': supplier.name,
        'phone': supplier.phone,
        'address': supplier.address,
      },
    );
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<Model.SupplierAPI> getSupplierDetail(String id) async {
    final Response response = await client.get('/supplier/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<Model.SupplierAPI, dynamic>(
        Model.SupplierAPI.fromJSON, response.data);
  }

  @override
  Future<List<Model.SupplierAPI>> getSuppliers() async {
    final Response response = await client.get('/supplier');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<Model.SupplierAPI>, List<dynamic>>(
        Model.SupplierAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSupplier(String id, Model.SupplierAPI supplier) async {
    final Response response = await client.patch('/supplier/$id', data: {
      'name': supplier.name,
      'phone': supplier.phone,
      'address': supplier.address,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> deleteSupplier(String id) async {
    final Response response = await client.delete('/supplier/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }
}
