import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';
import 'package:plastik_ui/helpers/request/parser.dart';

abstract class ReportAPI {
  Future<int> getCountTransactions();
  Future<double> getSummaryTransactions();
  Future<double> getSummaryTransactionsIn();
  Future<double> getSummaryTransactionOut();
  Future<double> getSummaryTransactionEtc();
  Future<List<ItemStockLogAPI>> getItemStockLogs();
}

class ReportAPIImplementation extends Object
    with ErrorHandler
    implements ReportAPI {
  Dio client;

  ReportAPIImplementation({
    @required this.client,
  });

  @override
  Future<int> getCountTransactions() async {
    final Response response = await client.get('/get-count-transactions');
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as int);
  }

  @override
  Future<List<ItemStockLogAPI>> getItemStockLogs() async {
    final Response response = await client.get('/get-item-stock-logs');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<ItemStockLogAPI>, List<dynamic>>(
        ItemStockLogAPI.fromListJSON, response.data);
  }

  @override
  Future<double> getSummaryTransactionEtc() async {
    final Response response = await client.get('/get-summary-transactions-etc');
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as double);
  }

  @override
  Future<double> getSummaryTransactionOut() async {
    final Response response = await client.get('/get-summary-transactions-out');
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as double);
  }

  @override
  Future<double> getSummaryTransactions() async {
    final Response response = await client.get('/get-summary-transactions');
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as double);
  }

  @override
  Future<double> getSummaryTransactionsIn() async {
    final Response response = await client.get('/get-summary-transactions-in');
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as double);
  }
}
