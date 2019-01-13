import 'package:flutter/material.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/home/blocs/summary-transactions.dart';
import 'package:Recet/presentations/screens/home/widgets/base-summary-report.dart';
import 'package:Recet/app.dart';

class SummaryTransactions extends StatefulWidget {
  @override
  _SummaryTransactionsState createState() => _SummaryTransactionsState();
}

class _SummaryTransactionsState extends State<SummaryTransactions> {
  SummaryTransactionsBloc _summaryTransactionsBloc;

  _SummaryTransactionsState() {
    _summaryTransactionsBloc =
        SummaryTransactionsBloc(reportService: getIt<ReportService>());
    _summaryTransactionsBloc.fetchAmountTransactions();
  }

  @override
  dispose() {
    _summaryTransactionsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _summaryTransactionsBloc.amountTransaction,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        return BaseSummaryReport(
          label: 'Total Keseluruhan Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError,
          onRetry: _summaryTransactionsBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
