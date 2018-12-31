import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/api/report.dart';
import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';
import 'package:plastik_ui/domains/report/transform/report.dart';

abstract class ReportService {
  Future<int> getCountTransactions();
  Future<double> getSummaryTransactions();
  Future<double> getSummaryTransactionsIn();
  Future<double> getSummaryTransactionOut();
  Future<double> getSummaryTransactionEtc();
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
  Future<int> getCountTransactions() async {
    return await api.getCountTransactions();
  }

  @override
  Future<List<ItemStockLog>> getItemStockLogs() async {
    List<ItemStockLogAPI> items = await api.getItemStockLogs();

    return transformer.makeModelGetItemStockLogs(items);
  }

  @override
  Future<double> getSummaryTransactionEtc() async {
    return await api.getSummaryTransactionEtc();
  }

  @override
  Future<double> getSummaryTransactionOut() async {
    return await api.getSummaryTransactionOut();
  }

  @override
  Future<double> getSummaryTransactions() async {
    return await api.getSummaryTransactions();
  }

  @override
  Future<double> getSummaryTransactionsIn() async {
    return await api.getSummaryTransactionsIn();
  }
}
