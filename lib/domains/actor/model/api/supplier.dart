class SupplierAPI {
  String id;
  String name;
  String phone;
  String address;
  String createdAt;

  SupplierAPI({this.id, this.name, this.phone, this.address, this.createdAt});

  static SupplierAPI fromJSON(dynamic json) => SupplierAPI(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        createdAt: json['createdAt'],
      );

  static List<SupplierAPI> fromListJSON(List<dynamic> jsons) {
    List<SupplierAPI> results = [];
    for (int i = 0; i < jsons.length; i++) {
      SupplierAPI supplier = SupplierAPI.fromJSON(jsons[i]);
      results.add(supplier);
    }

    return results;
  }
}
