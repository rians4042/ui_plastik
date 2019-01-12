import 'package:plastik_ui/domains/report/model/dto/transaction-detail.dart';

class TransactionOut {
  String note;
  String sellerId;
  List<TransactionItemDetail> details;
  List<String> images;

  TransactionOut({
    this.note,
    this.sellerId,
    this.details,
    this.images,
  });
}
