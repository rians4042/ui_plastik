import 'package:flutter/material.dart';
import 'package:Recet/presentations/screens/home/widgets/count-transactions.dart';
import 'package:Recet/presentations/screens/home/widgets/summary-transactions-etc.dart';
import 'package:Recet/presentations/screens/home/widgets/summary-transactions-in.dart';
import 'package:Recet/presentations/screens/home/widgets/summary-transactions-out.dart';
import 'package:Recet/presentations/screens/home/widgets/summary-transactions.dart';

final List<Widget> summaryReports = [
  CountTransactions(),
  SummaryTransactions(),
  SummaryTransactionsIn(),
  SummaryTransactionsOut(),
  SummaryTransactionsEtc(),
];
