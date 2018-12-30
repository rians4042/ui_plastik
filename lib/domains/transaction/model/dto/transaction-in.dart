import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';

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
