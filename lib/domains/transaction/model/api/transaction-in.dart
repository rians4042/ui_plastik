import 'package:plastik_ui/domains/report/model/api/transaction-detail.dart';

class TransactionInAPI {
  String note;
  String supplierId;
  List<TransactionItemDetailAPI> details;
  List<String> images;

  TransactionInAPI({this.note, this.supplierId, this.details, this.images});
}
