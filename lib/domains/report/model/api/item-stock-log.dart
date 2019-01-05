class ItemStockLogAPI {
  String itemId;
  String itemName;
  int qty;
  String unitName;

  ItemStockLogAPI({
    this.itemId,
    this.itemName,
    this.qty,
    this.unitName,
  });

  static ItemStockLogAPI fromJSON(Map<String, dynamic> res) {
    return ItemStockLogAPI(
        itemId: res['id'],
        itemName: res['name'],
        qty: res['qty'],
        unitName: res['unitName']);
  }

  static List<ItemStockLogAPI> fromListJSON(List<dynamic> res) {
    return res.map((item) => ItemStockLogAPI.fromJSON(item)).toList();
  }
}
