import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/blocs/summary-transactions.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/base-summary-report.dart';

class SummaryTransactions extends StatefulWidget {
  @override
  _SummaryTransactionsState createState() => _SummaryTransactionsState();
}

class _SummaryTransactionsState extends State<SummaryTransactions> {
  SummaryTransactionsBloc _summaryTransactionsBloc;

  _SummaryTransactionsState() {
    _summaryTransactionsBloc = SummaryTransactionsBloc();
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
        bool hasError = snapshot.error != null && snapshot.error != '';
        return BaseSummaryReport(
          label: 'Total Keseluruhan Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !hasError,
          error: snapshot.error != null && snapshot.error != '',
          onRetry: _summaryTransactionsBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
