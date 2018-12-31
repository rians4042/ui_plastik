import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/count-transactions.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/summary-transactions-etc.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/summary-transactions-in.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/summary-transactions-out.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/summary-transactions.dart';

final List<Widget> summaryReports = [
  CountTransactions(),
  SummaryTransactions(),
  SummaryTransactionsIn(),
  SummaryTransactionsOut(),
  SummaryTransactionsEtc(),
];
