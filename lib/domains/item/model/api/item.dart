class ItemAPI {
  String id;
  String name;
  String unitId;
  String createdAt;
  String itemCategoryId;

  ItemAPI({
    this.id,
    this.name,
    this.createdAt,
    this.itemCategoryId,
    this.unitId,
  });

  static ItemAPI fromJSON(Map<String, dynamic> json) {
    return ItemAPI(
      id: json['id'],
      name: json['name'],
      unitId: json['unitId'],
      createdAt: json['createdAt'],
      itemCategoryId: json['itemCategoryId'],
    );
  }

  static List<ItemAPI> fromListJSON(List<Map<String, dynamic>> jsons) {
    List<ItemAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            ItemAPI(
              id: json['id'],
              name: json['name'],
              unitId: json['unitId'],
              createdAt: json['createdAt'],
              itemCategoryId: json['itemCategoryId'],
            ),
          ),
    );

    return results;
  }
}
