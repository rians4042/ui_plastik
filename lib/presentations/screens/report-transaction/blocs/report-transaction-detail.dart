import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/model/dto/transaction-detail.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:rxdart/rxdart.dart';

class ReportTransactionDetailBloc {
  ReportTransactionDetailBloc({@required this.reportService}) {
    _transactionDetailController = BehaviorSubject<TransactionDetail>();
  }

  ReportService reportService;
  BehaviorSubject<TransactionDetail> _transactionDetailController;
  Stream<TransactionDetail> get transactionDetail =>
      _transactionDetailController.stream;

  Future<void> fetchReportTransaction(
      {@required String id, Function(String message) onError}) async {
    try {
      if (_transactionDetailController.stream.value == null) {
        TransactionDetail _transaction =
            await reportService.getTransactionDetail(id);
        _transactionDetailController.sink.add(_transaction);
      }
    } catch (e) {
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
      _transactionDetailController.sink
          .addError('Terjadi Kesalahan Pada Server');
    }
  }
}
