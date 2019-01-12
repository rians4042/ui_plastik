import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/api/report.dart';
import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/api/transaction-detail.dart';
import 'package:plastik_ui/domains/report/model/api/transaction.dart';
import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/dto/transaction-detail.dart';
import 'package:plastik_ui/domains/report/model/dto/transaction.dart';
import 'package:plastik_ui/domains/report/transform/report.dart';

abstract class ReportService {
  Future<List<Transaction>> getTransactions(
      int page, String startAt, String endAt);
  Future<TransactionDetail> getTransactionDetail(String id);
  Future<int> getCountTransactions(String startAt, String endAt);
  Future<double> getSummaryTransactions(String startAt, String endAt);
  Future<double> getSummaryTransactionsIn(String startAt, String endAt);
  Future<double> getSummaryTransactionsOut(String startAt, String endAt);
  Future<double> getSummaryTransactionsEtc(String startAt, String endAt);
  Future<List<ItemStockLog>> getItemStockLogs();
}

class ReportServiceImplementation implements ReportService {
  ReportAPI api;
  ReportTransformer transformer;

  ReportServiceImplementation({
    @required this.api,
    @required this.transformer,
  });

  @override
  Future<int> getCountTransactions(String startAt, String endAt) async {
    return await api.getCountTransactions(startAt, endAt);
  }

  @override
  Future<List<ItemStockLog>> getItemStockLogs() async {
    List<ItemStockLogAPI> items = await api.getItemStockLogs();

    return transformer.makeModelGetItemStockLogs(items);
  }

  @override
  Future<double> getSummaryTransactionsEtc(String startAt, String endAt) async {
    return await api.getSummaryTransactionsEtc(startAt, endAt);
  }

  @override
  Future<double> getSummaryTransactionsOut(String startAt, String endAt) async {
    return await api.getSummaryTransactionsOut(startAt, endAt);
  }

  @override
  Future<double> getSummaryTransactions(String startAt, String endAt) async {
    return await api.getSummaryTransactions(startAt, endAt);
  }

  @override
  Future<double> getSummaryTransactionsIn(String startAt, String endAt) async {
    return await api.getSummaryTransactionsIn(startAt, endAt);
  }

  @override
  Future<TransactionDetail> getTransactionDetail(String id) async {
    final TransactionDetailAPI transaction = await api.getTransactionDetail(id);
    return transformer.makeModelTransactionDetail(transaction);
  }

  @override
  Future<List<Transaction>> getTransactions(
      int page, String startAt, String endAt) async {
    final List<TransactionAPI> transactions =
        await api.getTransactions(page, startAt, endAt);
    return transformer.makeModelTransactions(transactions);
  }
}
