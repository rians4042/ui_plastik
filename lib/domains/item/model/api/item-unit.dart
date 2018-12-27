class ItemUnitAPI {
  String id;
  String name;
  String createdAt;

  ItemUnitAPI({
    this.id,
    this.name,
    this.createdAt,
  });

  static ItemUnitAPI fromJSON(Map<String, dynamic> json) {
    return ItemUnitAPI(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }

  static List<ItemUnitAPI> fromListJSON(List<Map<String, dynamic>> jsons) {
    List<ItemUnitAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            ItemUnitAPI(
              id: json['id'],
              name: json['name'],
              createdAt: json['createdAt'],
            ),
          ),
    );

    return results;
  }
}
