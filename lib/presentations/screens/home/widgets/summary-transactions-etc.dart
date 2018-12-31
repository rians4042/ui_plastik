import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/blocs/summary-transactions-etc.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/base-summary-report.dart';

class SummaryTransactionsEtc extends StatefulWidget {
  @override
  _SummaryTransactionsEtcState createState() => _SummaryTransactionsEtcState();
}

class _SummaryTransactionsEtcState extends State<SummaryTransactionsEtc> {
  SummaryTransactionsEtcBloc _summaryTransactionsEtcBloc;

  _SummaryTransactionsEtcState() {
    _summaryTransactionsEtcBloc = SummaryTransactionsEtcBloc();
    _summaryTransactionsEtcBloc.fetchAmountTransactions();
  }

  @override
  dispose() {
    _summaryTransactionsEtcBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _summaryTransactionsEtcBloc.amountTransaction,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        bool hasError = snapshot.error != null && snapshot.error != '';
        return BaseSummaryReport(
          label: 'Total Pengeluaran Lainnya Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !hasError,
          error: snapshot.error != null && snapshot.error != '',
          onRetry: _summaryTransactionsEtcBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
