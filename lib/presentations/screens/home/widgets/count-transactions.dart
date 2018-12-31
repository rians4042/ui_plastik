import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/blocs/count-transactions.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/base-summary-report.dart';

class CountTransactions extends StatefulWidget {
  @override
  _CountTransactionsState createState() => _CountTransactionsState();
}

class _CountTransactionsState extends State<CountTransactions> {
  CountTransactionsBloc _countTransactionsBloc;

  _CountTransactionsState() {
    _countTransactionsBloc = CountTransactionsBloc();
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
        bool hasError = snapshot.error != null && snapshot.error != '';
        return BaseSummaryReport(
          label: 'Jumlah Transaksi Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !hasError,
          error: snapshot.error != null && snapshot.error != '',
          onRetry: _countTransactionsBloc.fetchCountTransactions,
        );
      },
    );
  }
}
