import 'dart:async';

import 'package:meta/meta.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/helpers/number/format-currency.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class SummaryTransactionsInBloc implements BaseBloc {
  BehaviorSubject<String> _statesSummaryTransaction;
  Stream<String> get amountTransaction => _statesSummaryTransaction.stream;
  ReportService reportService;

  SummaryTransactionsInBloc({@required this.reportService}) {
    _statesSummaryTransaction = BehaviorSubject<String>();
  }

  Future<void> fetchAmountTransactions() async {
    try {
      DateTime now = DateTime.now();
      DateTime curr = DateTime(now.year, now.month, 1);
      DateTime next = DateTime(now.year, now.month + 1, 1);

      // create filtering
      String startAt = '${curr.year}-${curr.month}-${curr.day} 00:00:00';
      String endAt = '${next.year}-${next.month}-${next.day} 00:00:00';

      double amount =
          await reportService.getSummaryTransactionsIn(startAt, endAt);
      _statesSummaryTransaction.sink.add(formatCurrency(amount));
    } catch (e) {
      _statesSummaryTransaction.sink.addError('Tidak dapat memuat');
    }
  }

  @override
  void dispose() {
    _statesSummaryTransaction?.close();
  }
}
