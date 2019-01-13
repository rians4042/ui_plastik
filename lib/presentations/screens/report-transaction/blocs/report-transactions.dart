import 'package:meta/meta.dart';
import 'package:Recet/domains/report/model/dto/transaction.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/report-transaction/states/report-transactions.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class ReportTransactionsBloc implements BaseBloc {
  ReportTransactionsBloc({@required this.reportService}) {
    _state = ReportTransactionsState.empty();
    _statesReportTransactions = BehaviorSubject<ReportTransactionsState>(
        seedValue: ReportTransactionsState.empty());
  }

  ReportTransactionsState _state;
  ReportService reportService;

  BehaviorSubject<ReportTransactionsState> _statesReportTransactions;
  Stream<ReportTransactionsState> get reportTransactions =>
      _statesReportTransactions.stream;

  void fetchingTransactions(
      {bool paging, @required Function(String message) onError}) async {
    try {
      if (_state.hasNext || !paging) {
        _statesReportTransactions.sink.add(_state..beginFetchTransactions());
        List<Transaction> _transactions = await reportService.getTransactions(
            _state.page,
            _state.startAt != null ? _state.startAt.toString() : '',
            _state.endAt != null ? _state.endAt.toString() : '');
        _statesReportTransactions.sink
            .add(_state..successFetchTransactions(paging, _transactions));
      }
    } catch (e) {
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
      _statesReportTransactions.addError('Terjadi Kesalahan Pada Server');
    }
  }

  @override
  void dispose() {
    _statesReportTransactions?.close();
  }
}
