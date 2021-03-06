import 'package:flutter/material.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/home/blocs/summary-transactions-etc.dart';
import 'package:Recet/presentations/screens/home/widgets/base-summary-report.dart';
import 'package:Recet/app.dart';

class SummaryTransactionsEtc extends StatefulWidget {
  @override
  _SummaryTransactionsEtcState createState() => _SummaryTransactionsEtcState();
}

class _SummaryTransactionsEtcState extends State<SummaryTransactionsEtc> {
  SummaryTransactionsEtcBloc _summaryTransactionsEtcBloc;

  _SummaryTransactionsEtcState() {
    _summaryTransactionsEtcBloc =
        SummaryTransactionsEtcBloc(reportService: getIt<ReportService>());
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
        return BaseSummaryReport(
          label: 'Total Pengeluaran Lainnya Bulan Ini',
          value: !snapshot.hasData ? '' : snapshot.data,
          loading: !snapshot.hasData && !snapshot.hasError,
          error: snapshot.hasError,
          onRetry: _summaryTransactionsEtcBloc.fetchAmountTransactions,
        );
      },
    );
  }
}
