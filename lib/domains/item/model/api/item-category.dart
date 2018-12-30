class ItemCategoryAPI {
  String id;
  String name;
  String createdAt;

  ItemCategoryAPI({
    this.id,
    this.name,
    this.createdAt,
  });

  static ItemCategoryAPI fromJSON(dynamic json) {
    return ItemCategoryAPI(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }

  static List<ItemCategoryAPI> fromListJSON(List<dynamic> jsons) {
    List<ItemCategoryAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            ItemCategoryAPI(
              id: json['id'],
              name: json['name'],
              createdAt: json['createdAt'],
            ),
          ),
    );

    return results;
  }
}
