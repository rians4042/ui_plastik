class Transaction {
  String note;
  String id;
  double amount;
  String type;
  String typeName;
  String createdAt;

  Transaction({
    this.id,
    this.note,
    this.amount,
    this.type,
    this.typeName,
    this.createdAt,
  });
}
