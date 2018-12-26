import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/api/actor.dart';
import 'package:plastik_ui/domains/actor/model/api/supplier.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/transform/actor.dart';

abstract class ActorService {
  Future<List<Supplier>> getSuppliers();
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
}
