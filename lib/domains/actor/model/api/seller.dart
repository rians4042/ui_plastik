class SellerAPI {
  String id;
  String name;
  String phone;
  String address;
  String createdAt;

  SellerAPI({this.id, this.name, this.phone, this.address, this.createdAt});

  static SellerAPI fromJSON(dynamic json) => SellerAPI(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        createdAt: json['createdAt'],
      );

  static List<SellerAPI> fromListJSON(List<dynamic> jsons) {
    List<SellerAPI> results = [];
    for (int i = 0; i < jsons.length; i++) {
      results.add(
        SellerAPI.fromJSON(jsons[i]),
      );
    }
    return results;
  }
}
