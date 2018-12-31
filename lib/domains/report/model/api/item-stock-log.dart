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
        itemId: res['itemId'],
        itemName: res['itemName'],
        qty: res['qty'],
        unitName: res['unitName']);
  }

  static List<ItemStockLogAPI> fromListJSON(List<dynamic> res) {
    return res.map((item) => ItemStockLogAPI.fromJSON(item));
  }
}
