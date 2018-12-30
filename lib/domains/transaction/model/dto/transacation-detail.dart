class TransactionDetail {
  String note;
  String id;
  double amount;
  String type;
  String typeName;
  String createdAt;
  String transactionOutId;
  String sellerId;
  String sellerName;
  String transactionInId;
  String supplierId;
  String supplierName;
  String transactionEtcId;
  String transactionEtcTypeName;
  List<TransactionItemDetail> details;
  List<TransactionImage> images;

  TransactionDetail({
    this.note,
    this.id,
    this.amount,
    this.type,
    this.typeName,
    this.createdAt,
    this.transactionOutId,
    this.sellerId,
    this.sellerName,
    this.transactionInId,
    this.supplierId,
    this.supplierName,
    this.transactionEtcId,
    this.transactionEtcTypeName,
    this.details,
    this.images,
  });
}

class TransactionItemDetail {
  String id;
  String itemId;
  int qty;
  double amount;
  String itemName;

  TransactionItemDetail(
      {this.id, this.itemId, this.qty, this.amount, this.itemName});
}

class TransactionImage {
  String id;
  String image;

  TransactionImage({
    this.id,
    this.image,
  });
}
