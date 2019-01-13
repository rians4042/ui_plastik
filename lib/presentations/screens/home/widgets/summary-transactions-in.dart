import 'package:flutter/material.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/home/blocs/summary-transactions-in.dart';
import 'package:Recet/presentations/screens/home/widgets/base-summary-report.dart';
import 'package:Recet/app.dart';

class SummaryTransactionsIn extends StatefulWidget {
  @override
  _SummaryTransactionsInState createState() => _SummaryTransactionsInState();
}

class _SummaryTransactionsInState extends State<SummaryTransactionsIn> {
  SummaryTransactionsInBloc _summaryTransactionsInBloc;

  _SummaryTransactionsInState() {
    _summaryTransactionsInBloc =
        SummaryTransactionsInBloc(reportService: getIt<ReportService>());
    _summaryTransactionsInBloc.fetchAmountTransactions();
  }

  @override
  dispose() {
    _summaryTransactionsInBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _summaryTransactionsInBloc.amountTransaction,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        return BaseSummaryReport(
          label: 'Total Pengeluaran Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError,
          onRetry: _summaryTransactionsInBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
