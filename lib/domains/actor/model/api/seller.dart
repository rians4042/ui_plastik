class SellerAPI {
  String id;
  String name;
  String createdAt;

  SellerAPI({this.id, this.name, this.createdAt});

  static SellerAPI fromJSON(Map<String, dynamic> json) => SellerAPI(
        id: json['id'],
        name: json['name'],
        createdAt: json['createdAt'],
      );

  static List<SellerAPI> fromListJSON(List<Map<String, dynamic>> jsons) {
    List<SellerAPI> results = [];
    for (int i = 0; i < jsons.length; i++) {
      results.add(
        SellerAPI(
            id: jsons[i]['id'],
            name: jsons[i]['name'],
            createdAt: jsons[i]['createdAt']),
      );
    }
    return results;
  }
}
