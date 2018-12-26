import 'package:flutter/material.dart';

class SupplierAPI {
  String id;
  String name;
  String createdAt;

  SupplierAPI(
      {@required this.id, @required this.name, @required this.createdAt});

  static SupplierAPI fromJSON(Map<String, dynamic> json) => SupplierAPI(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'],
      );

  static List<SupplierAPI> fromListJSON(List<Map<String, dynamic>> jsons) {
    List<SupplierAPI> results = [];
    for (int i = 0; i < jsons.length; i++) {
      SupplierAPI supplier = SupplierAPI.fromJSON(jsons[i]);
      results.add(supplier);
    }

    return results;
  }
}
