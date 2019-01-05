import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/blocs/summary-transactions-in.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/base-summary-report.dart';

class SummaryTransactionsIn extends StatefulWidget {
  @override
  _SummaryTransactionsInState createState() => _SummaryTransactionsInState();
}

class _SummaryTransactionsInState extends State<SummaryTransactionsIn> {
  SummaryTransactionsInBloc _summaryTransactionsInBloc;

  _SummaryTransactionsInState() {
    _summaryTransactionsInBloc = SummaryTransactionsInBloc();
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
        bool hasError = snapshot.error != null && snapshot.error != '';
        return BaseSummaryReport(
          label: 'Total Pemasukkan Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !hasError,
          error: snapshot.error != null && snapshot.error != '',
          onRetry: _summaryTransactionsInBloc.fetchAmountTransactions,
        );
      },
    );
  }
}