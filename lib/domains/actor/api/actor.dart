import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:dio/dio.dart';
import 'package:plastik_ui/helpers/request/parser.dart';
import 'package:plastik_ui/helpers/request/validator.dart';

abstract class ActorAPI {
  Future<bool> createSupplier();
  Future<bool> updateSupplier();
  Future<List<SupplierAPI>> getSuppliers();
  Future<SupplierAPI> getSupplierDetail();
  Future<bool> createSeller();
  Future<bool> updateSeller();
  Future<List<SupplierAPI>> getSellers();
  Future<SupplierAPI> getSellerDetail();
}

class ActorAPIImplementation implements ActorAPI {
  final Dio client;

  ActorAPIImplementation({
    @required this.client,
  });

  @override
  Future<bool> createSeller() {
    // TODO: implement createSeller
    return null;
  }

  @override
  Future<bool> createSupplier() {
    // TODO: implement createSupplier
    return null;
  }

  @override
  Future<SupplierAPI> getSellerDetail() {
    // TODO: implement getSellerDetail
    return null;
  }

  @override
  Future<List<SupplierAPI>> getSellers() {
    // TODO: implement getSellers
    return null;
  }

  @override
  Future<SupplierAPI> getSupplierDetail() {
    // TODO: implement getSupplierDetail
    return null;
  }

  @override
  Future<List<SupplierAPI>> getSuppliers() async {
    final Response response = await client.get('suppliers');
    scanErrorRequest(response);
    return parserRawRequest<List<SupplierAPI>, List<Map<String, dynamic>>>(
        SupplierAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> updateSeller() {
    // TODO: implement updateSeller
    return null;
  }

  @override
  Future<bool> updateSupplier() {
    // TODO: implement updateSupplier
    return null;
  }
}
