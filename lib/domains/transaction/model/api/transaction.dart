class TransactionAPI {
  String note;
  String id;
  double amount;
  String type;
  String typeName;
  String createdAt;

  TransactionAPI({
    this.note,
    this.id,
    this.amount,
    this.type,
    this.typeName,
    this.createdAt,
  });

  static TransactionAPI fromJSON(dynamic json) => TransactionAPI(
        id: json['id'],
        note: json['note'],
        amount: json['amount'],
        type: json['type'],
        typeName: json['typeName'],
        createdAt: json['createdAt'],
      );

  static List<TransactionAPI> fromListJSON(List<dynamic> jsons) {
    List<TransactionAPI> results = [];
    jsons.forEach(
      (json) => results.add(
            TransactionAPI(
              id: json['id'],
              note: json['note'],
              amount: json['amount'],
              type: json['type'],
              typeName: json['typeName'],
              createdAt: json['createdAt'],
            ),
          ),
    );

    return results;
  }
}
