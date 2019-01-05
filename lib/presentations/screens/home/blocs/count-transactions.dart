import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class CountTransactionsBloc implements BaseBloc {
  BehaviorSubject<String> _statesCountTransaction;
  Stream<String> get countTransaction => _statesCountTransaction.stream;
  ReportService reportService;

  CountTransactionsBloc({@required this.reportService}) {
    _statesCountTransaction = BehaviorSubject<String>();
  }

  Future<void> fetchCountTransactions() async {
    try {
      DateTime now = DateTime.now();
      DateTime curr = DateTime(now.year, now.month, 1);
      DateTime next = DateTime(now.year, now.month + 1, 1);

      // create filtering
      String startAt = '${curr.year}-${curr.month}-${curr.day} 00:00:00';
      String endAt = '${next.year}-${next.month}-${next.day} 00:00:00';

      int count = await reportService.getCountTransactions(startAt, endAt);

      _statesCountTransaction.sink.add(count.toString());
    } catch (e) {
      _statesCountTransaction.sink.addError('Tidak dapat memuat');
    }
  }

  @override
  void dispose() {
    _statesCountTransaction?.close();
  }
}
