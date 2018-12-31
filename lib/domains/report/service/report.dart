import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/api/report.dart';
import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';
import 'package:plastik_ui/domains/report/transform/report.dart';

abstract class ReportService {
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
}
