import 'package:flutter/material.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/home/blocs/count-transactions.dart';
import 'package:Recet/presentations/screens/home/widgets/base-summary-report.dart';
import 'package:Recet/app.dart';

class CountTransactions extends StatefulWidget {
  @override
  _CountTransactionsState createState() => _CountTransactionsState();
}

class _CountTransactionsState extends State<CountTransactions> {
  CountTransactionsBloc _countTransactionsBloc;

  _CountTransactionsState() {
    _countTransactionsBloc =
        CountTransactionsBloc(reportService: getIt<ReportService>());
    _countTransactionsBloc.fetchCountTransactions();
  }

  @override
  dispose() {
    _countTransactionsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _countTransactionsBloc.countTransaction,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        return BaseSummaryReport(
          label: 'Jumlah Transaksi Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError,
          onRetry: _countTransactionsBloc.fetchCountTransactions,
        );
      },
    );
  }
}
