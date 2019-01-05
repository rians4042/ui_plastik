import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/blocs/summary-transactions-out.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/base-summary-report.dart';

class SummaryTransactionsOut extends StatefulWidget {
  @override
  _SummaryTransactionsOutState createState() => _SummaryTransactionsOutState();
}

class _SummaryTransactionsOutState extends State<SummaryTransactionsOut> {
  SummaryTransactionsOutBloc _summaryTransactionsOutBloc;

  _SummaryTransactionsOutState() {
    _summaryTransactionsOutBloc = SummaryTransactionsOutBloc();
    _summaryTransactionsOutBloc.fetchAmountTransactions();
  }

  @override
  dispose() {
    _summaryTransactionsOutBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _summaryTransactionsOutBloc.amountTransaction,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        bool hasError = snapshot.error != null && snapshot.error != '';
        return BaseSummaryReport(
          label: 'Total Pengeluaran Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !hasError,
          error: snapshot.error != null && snapshot.error != '',
          onRetry: _summaryTransactionsOutBloc.fetchAmountTransactions,
        );
      },
    );
  }
}