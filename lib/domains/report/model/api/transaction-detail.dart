class TransactionDetailAPI {
  String note;
  String id;
  int amount;
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
  List<TransactionItemDetailAPI> details;
  List<TransactionImageAPI> images;

  TransactionDetailAPI({
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

  static TransactionDetailAPI fromJSON(dynamic json) => TransactionDetailAPI(
        id: json['id'],
        note: json['note'],
        amount: json['amount'],
        type: json['type'],
        typeName: json['typeName'],
        createdAt: json['createdAt'],
        transactionEtcId: json['transactionEtcId'],
        sellerId: json['sellerId'],
        details: TransactionItemDetailAPI.fromListJSON(json['details']),
        images: TransactionImageAPI.fromListJSON(json['images']),
        transactionEtcTypeName: json['transactionEtcTypeName'],
        transactionInId: json['transactionInId'],
        transactionOutId: json['transactionOutId'],
        sellerName: json['sellerName'],
        supplierId: json['supplierId'],
        supplierName: json['supplierName'],
      );
}

class TransactionItemDetailAPI {
  String id;
  String itemId;
  int qty;
  double amount;
  String itemName;

  TransactionItemDetailAPI(
      {this.id, this.itemId, this.qty, this.amount, this.itemName});

  static TransactionItemDetailAPI fromJSON(dynamic json) =>
      TransactionItemDetailAPI(
        id: json['id'],
        itemId: json['itemId'],
        qty: json['qty'],
        amount: json['amount'],
        itemName: json['itemName'],
      );

  static List<TransactionItemDetailAPI> fromListJSON(List<dynamic> jsons) {
    List<TransactionItemDetailAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            TransactionItemDetailAPI(
              id: json['id'],
              amount: double.parse(json['amount'].toString()),
              qty: json['qty'],
              itemId: json['itemId'],
              itemName: json['itemName'],
            ),
          ),
    );

    return results;
  }
}

class TransactionImageAPI {
  String id;
  String image;

  TransactionImageAPI({
    this.id,
    this.image,
  });

  static TransactionImageAPI fromJSON(dynamic json) => TransactionImageAPI(
        id: json['id'],
        image: json['image'],
      );

  static List<TransactionImageAPI> fromListJSON(List<dynamic> jsons) {
    List<TransactionImageAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            TransactionImageAPI(
              id: json['id'],
              image: json['image'],
            ),
          ),
    );

    return results;
  }
}
