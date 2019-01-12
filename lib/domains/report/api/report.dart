import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/api/transaction-detail.dart';
import 'package:plastik_ui/domains/report/model/api/transaction.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';
import 'package:plastik_ui/helpers/request/parser.dart';

abstract class ReportAPI {
  Future<List<TransactionAPI>> getTransactions(
      int page, String startAt, String endAt);
  Future<TransactionDetailAPI> getTransactionDetail(String id);
  Future<int> getCountTransactions(String startAt, String endAt);
  Future<double> getSummaryTransactions(String startAt, String endAt);
  Future<double> getSummaryTransactionsIn(String startAt, String endAt);
  Future<double> getSummaryTransactionsOut(String startAt, String endAt);
  Future<double> getSummaryTransactionsEtc(String startAt, String endAt);
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
  Future<int> getCountTransactions(String startAt, String endAt) async {
    final Response response = await client.get(
      '/report/get-count-transactions',
      data: {
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return (response.data['value'] as int);
  }

  @override
  Future<List<ItemStockLogAPI>> getItemStockLogs() async {
    final Response response = await client.get('/report/get-item-stock-logs');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<ItemStockLogAPI>, List<dynamic>>(
        ItemStockLogAPI.fromListJSON, response.data);
  }

  @override
  Future<double> getSummaryTransactionsEtc(String startAt, String endAt) async {
    final Response response = await client.get(
      '/report/get-summary-transactions-etc',
      data: {
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return double.parse(response.data['value'].toString());
  }

  @override
  Future<double> getSummaryTransactionsOut(String startAt, String endAt) async {
    final Response response = await client.get(
      '/report/get-summary-transactions-out',
      data: {
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return double.parse(response.data['value'].toString());
  }

  @override
  Future<double> getSummaryTransactions(String startAt, String endAt) async {
    final Response response = await client.get(
      '/report/get-summary-transactions',
      data: {
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return double.parse(response.data['value'].toString());
  }

  @override
  Future<double> getSummaryTransactionsIn(String startAt, String endAt) async {
    final Response response = await client.get(
      '/report/get-summary-transactions-in',
      data: {
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return double.parse(response.data['value'].toString());
  }

  @override
  Future<TransactionDetailAPI> getTransactionDetail(String id) async {
    final Response response = await client.get('/transaction/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<TransactionDetailAPI, dynamic>(
        TransactionDetailAPI.fromJSON, response.data);
  }

  @override
  Future<List<TransactionAPI>> getTransactions(
      int page, String startAt, String endAt) async {
    final Response response = await client.get(
      '/transaction',
      data: {
        'page': page,
        'orderBy': '',
        'startAt': startAt,
        'endAt': endAt,
      },
    );
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<TransactionAPI>, List<dynamic>>(
        TransactionAPI.fromListJSON, response.data);
  }
}
