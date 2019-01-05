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
        return BaseSummaryReport(
          label: 'Total Pemasukan Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError,
          onRetry: _summaryTransactionsOutBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
