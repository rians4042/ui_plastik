import 'package:flutter/material.dart';
import 'package:Recet/domains/actor/api/seller.dart';
import 'package:Recet/domains/actor/api/supplier.dart';
import 'package:Recet/domains/actor/model/api/seller.dart' as SellerModel;
import 'package:Recet/domains/actor/model/api/supplier.dart'
    as SupplierModel;
import 'package:Recet/domains/actor/model/dto/seller.dart';
import 'package:Recet/domains/actor/model/dto/supplier.dart';
import 'package:Recet/domains/actor/transform/actor.dart';

abstract class ActorService {
  Future<List<Supplier>> getSuppliers();
  Future<List<Seller>> getSellers();
  Future<Supplier> getSupplierDetail(String id);
  Future<Seller> getSellerDetail(String id);
  Future<bool> createSupplier(Supplier supplier);
  Future<bool> createSeller(Seller seller);
  Future<bool> updateSupplier(String id, Supplier supplier);
  Future<bool> updateSeller(String id, Seller seller);
  Future<bool> deleteSupplier(String id);
  Future<bool> deleteSeller(String id);
}

class ActorServiceImplementation implements ActorService {
  SellerAPI sellerAPI;
  SupplierAPI supplierAPI;
  ActorTransformer transformer;

  ActorServiceImplementation({
    @required this.sellerAPI,
    @required this.supplierAPI,
    @required this.transformer,
  });

  @override
  Future<List<Supplier>> getSuppliers() async {
    List<SupplierModel.SupplierAPI> results =
        await this.supplierAPI.getSuppliers();
    return transformer.makeModelSuppliers(results);
  }

  @override
  Future<bool> createSeller(Seller seller) async {
    return await sellerAPI.createSeller(transformer.makeModelSellerAPI(seller));
  }

  @override
  Future<bool> createSupplier(Supplier supplier) async {
    return await supplierAPI
        .createSupplier(transformer.makeModelSupplierAPI(supplier));
  }

  @override
  Future<bool> deleteSeller(String id) async {
    return await sellerAPI.deleteSeller(id);
  }

  @override
  Future<bool> deleteSupplier(String id) async {
    return await supplierAPI.deleteSupplier(id);
  }

  @override
  Future<Seller> getSellerDetail(String id) async {
    final SellerModel.SellerAPI seller = await sellerAPI.getSellerDetail(id);
    return transformer.makeModelSeller(seller);
  }

  @override
  Future<List<Seller>> getSellers() async {
    final List<SellerModel.SellerAPI> sellers = await sellerAPI.getSellers();
    return transformer.makeModelSellers(sellers);
  }

  @override
  Future<Supplier> getSupplierDetail(String id) async {
    final SupplierModel.SupplierAPI supplier =
        await supplierAPI.getSupplierDetail(id);
    return transformer.makeModelSupplier(supplier);
  }

  @override
  Future<bool> updateSeller(String id, Seller _seller) async {
    final SellerModel.SellerAPI seller =
        transformer.makeModelSellerAPI(_seller);
    return await sellerAPI.updateSeller(id, seller);
  }

  @override
  Future<bool> updateSupplier(String id, Supplier _supplier) async {
    final SupplierModel.SupplierAPI supplier =
        transformer.makeModelSupplierAPI(_supplier);
    return await supplierAPI.updateSupplier(id, supplier);
  }
}
