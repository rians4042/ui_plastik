import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction.dart'
    as model;
import 'package:plastik_ui/domains/transaction/model/api/transaction-detail.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-in.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-out.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-etc.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-etc-type.dart';
import 'package:plastik_ui/helpers/request/error-handler.dart';
import 'package:plastik_ui/helpers/request/parser.dart';

abstract class TransactionAPI {
  Future<List<model.TransactionAPI>> getTransactions();
  Future<TransactionDetailAPI> getTransactionDetail(String id);
  Future<List<TransactionEtcTypeAPI>> getTransactionEtcTypes();
  Future<TransactionEtcTypeAPI> getTransactionEtcTypeDetail(String id);
  Future<bool> createTransactionIn(TransactionInAPI trx);
  Future<bool> createTransactionOut(TransactionOutAPI trx);
  Future<bool> createTransactionEtc(TransactionEtcAPI trx);
  Future<bool> createTransactionEtcType(TransactionEtcTypeAPI type);
  Future<bool> updateTransactionEtcType(String id, TransactionEtcTypeAPI type);
  Future<bool> deleteTransactionEtcType(String id);
}

class TransactionAPIImplementation extends Object
    with ErrorHandler
    implements TransactionAPI {
  Dio client;

  TransactionAPIImplementation({@required this.client});

  @override
  Future<bool> createTransactionEtc(TransactionEtcAPI trx) async {
    final Response response = await client.post('/transaction/etc', data: {
      'note': trx.note,
      'amount': trx.amount,
      'type': trx.type,
      'images': trx.images,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> createTransactionEtcType(TransactionEtcTypeAPI type) async {
    final Response response = await client.post('/transaction/etc/type', data: {
      'name': type.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> createTransactionIn(TransactionInAPI trx) async {
    final Response response = await client.post('/transaction/in', data: {
      'note': trx.note,
      'supplierId': trx.supplierId,
      'details': trx.details
          .map((t) => {'itemId': t.itemId, 'qty': t.qty, 'amount': t.amount})
          .toList(),
      'images': trx.images,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<bool> createTransactionOut(TransactionOutAPI trx) async {
    final Response response = await client.post('/transaction/in', data: {
      'note': trx.note,
      'sellerId': trx.sellerId,
      'details': trx.details
          .map((t) => {'itemId': t.itemId, 'qty': t.qty, 'amount': t.amount})
          .toList(),
      'images': trx.images,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<TransactionDetailAPI> getTransactionDetail(String id) async {
    final Response response = await client.get('/transaction/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<TransactionDetailAPI, Map<String, dynamic>>(
        TransactionDetailAPI.fromJSON, response.data);
  }

  @override
  Future<List<model.TransactionAPI>> getTransactions() async {
    final Response response = await client.get('/transaction');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<model.TransactionAPI>,
            List<Map<String, dynamic>>>(
        model.TransactionAPI.fromListJSON, response.data);
  }

  @override
  Future<bool> deleteTransactionEtcType(String id) async {
    final Response response = await client.delete('/transaction/$id');
    throwErrorIfErrorFounded(response);
    return true;
  }

  @override
  Future<List<TransactionEtcTypeAPI>> getTransactionEtcTypes() async {
    final Response response = await client.get('/transaction/etc/type');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<List<TransactionEtcTypeAPI>,
            List<Map<String, dynamic>>>(
        TransactionEtcTypeAPI.fromListJSON, response.data);
  }

  @override
  Future<TransactionEtcTypeAPI> getTransactionEtcTypeDetail(String id) async {
    final Response response = await client.get('/transaction/etc/type/$id');
    throwErrorIfErrorFounded(response);
    return parserRawRequest<TransactionEtcTypeAPI, Map<String, dynamic>>(
        TransactionEtcTypeAPI.fromJSON, response.data);
  }

  @override
  Future<bool> updateTransactionEtcType(
      String id, TransactionEtcTypeAPI type) async {
    final Response response =
        await client.patch('/transaction/etc/type/$id', data: {
      'name': type.name,
    });
    throwErrorIfErrorFounded(response);
    return true;
  }
}
