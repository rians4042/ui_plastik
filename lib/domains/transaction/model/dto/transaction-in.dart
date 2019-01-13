import 'package:Recet/domains/report/model/dto/transaction-detail.dart';

class TransactionIn {
  String note;
  String supplierId;
  List<TransactionItemDetail> details;
  List<String> images;

  TransactionIn({
    this.note,
    this.supplierId,
    this.details,
    this.images,
  });
}
