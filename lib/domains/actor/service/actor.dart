import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/api/actor.dart';
import 'package:plastik_ui/domains/actor/model/api/seller.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/transform/actor.dart';

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
  ActorAPI api;
  ActorTransformer transformer;

  ActorServiceImplementation({@required this.api});

  @override
  Future<List<Supplier>> getSuppliers() async {
    List<SupplierAPI> results = await this.api.getSuppliers();
    return transformer.makeModelSuppliers(results);
  }

  @override
  Future<bool> createSeller(Seller seller) async {
    return await api.createSeller(transformer.makeModelSellerAPI(seller));
  }

  @override
  Future<bool> createSupplier(Supplier supplier) async {
    return await api.createSupplier(transformer.makeModelSupplierAPI(supplier));
  }

  @override
  Future<bool> deleteSeller(String id) async {
    return await api.deleteSeller(id);
  }

  @override
  Future<bool> deleteSupplier(String id) async {
    return await api.deleteSupplier(id);
  }

  @override
  Future<Seller> getSellerDetail(String id) async {
    final SellerAPI seller = await api.getSellerDetail(id);
    return transformer.makeModelSeller(seller);
  }

  @override
  Future<List<Seller>> getSellers() async {
    final List<SellerAPI> sellers = await api.getSellers();
    return transformer.makeModelSellers(sellers);
  }

  @override
  Future<Supplier> getSupplierDetail(String id) async {
    final SupplierAPI supplier = await api.getSupplierDetail(id);
    return transformer.makeModelSupplier(supplier);
  }

  @override
  Future<bool> updateSeller(String id, Seller _seller) async {
    final SellerAPI seller = transformer.makeModelSellerAPI(_seller);
    return await api.updateSeller(id, seller);
  }

  @override
  Future<bool> updateSupplier(String id, Supplier _supplier) async {
    final SupplierAPI supplier = transformer.makeModelSupplierAPI(_supplier);
    return await api.updateSupplier(id, supplier);
  }
}
