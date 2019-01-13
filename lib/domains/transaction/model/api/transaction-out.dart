import 'package:Recet/domains/report/model/api/transaction-detail.dart';

class TransactionOutAPI {
  String note;
  String sellerId;
  List<TransactionItemDetailAPI> details;
  List<String> images;

  TransactionOutAPI({this.note, this.sellerId, this.details, this.images});
}
