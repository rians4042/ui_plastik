class TransactionAPIModel {
  String note;
  String sellerId;
  List<Detail> details;
  List<String> images;

  TransactionAPIModel({
    this.note,
    this.sellerId,
    this.details,
    this.images,
  });
}

class Detail {
  String itemId;
  int qty;
  int amount;

  Detail({
    this.itemId,
    this.qty,
    this.amount,
  });
}
