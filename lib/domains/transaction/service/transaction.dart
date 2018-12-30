import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/transaction/api/transaction.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction.dart'
    as modelTransacation;
import 'package:plastik_ui/domains/transaction/model/api/transaction-detail.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-in.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-out.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction.dart';
import 'package:plastik_ui/domains/transaction/transform/transaction.dart';

abstract class TransactionService {
  Future<List<Transaction>> getTransactions();
  Future<TransactionDetail> getTransactionDetail(String id);
  Future<List<TransactionEtcType>> getTransactionEtcTypes();
  Future<TransactionEtcType> getTransactionEtcTypeDetail(String id);
  Future<bool> createTransactionIn(TransactionIn trx);
  Future<bool> createTransactionOut(TransactionOut trx);
  Future<bool> createTransactionEtc(TransactionEtc trx);
  Future<bool> createTransactionEtcType(TransactionEtcType type);
  Future<bool> updateTransactionEtcType(String id, TransactionEtcType type);
  Future<bool> deleteTransactionEtcType(String id);
}

class TransactionServiceImplementation implements TransactionService {
  TransactionAPI api;
  TransactionTransformer transformer;

  TransactionServiceImplementation({
    @required this.api,
    @required this.transformer,
  });

  @override
  Future<bool> createTransactionEtc(TransactionEtc trx) async {
    await api.createTransactionEtc(transformer.makeModelTransactionEtcAPI(trx));
    return true;
  }

  @override
  Future<bool> createTransactionEtcType(TransactionEtcType type) async {
    await api.createTransactionEtcType(
        transformer.makeModelTransactionEtcTypeAPI(type));
    return true;
  }

  @override
  Future<bool> createTransactionIn(TransactionIn trx) async {
    await api.createTransactionIn(transformer.makeModelTransactionInAPI(trx));
    return true;
  }

  @override
  Future<bool> createTransactionOut(TransactionOut trx) async {
    await api.createTransactionOut(transformer.makeModelTransactionOutAPI(trx));
    return true;
  }

  @override
  Future<bool> deleteTransactionEtcType(String id) async {
    await api.deleteTransactionEtcType(id);
    return true;
  }

  @override
  Future<TransactionDetail> getTransactionDetail(String id) async {
    final TransactionDetailAPI transaction = await api.getTransactionDetail(id);
    return transformer.makeModelTransactionDetail(transaction);
  }

  @override
  Future<List<TransactionEtcType>> getTransactionEtcTypes() async {
    final List<TransactionEtcTypeAPI> transactionEtcTypes =
        await api.getTransactionEtcTypes();
    return transformer.makeModelTransactionEtcTypes(transactionEtcTypes);
  }

  @override
  Future<TransactionEtcType> getTransactionEtcTypeDetail(String id) async {
    final TransactionEtcTypeAPI transactionEtcType =
        await api.getTransactionEtcTypeDetail(id);
    return transformer.makeModelTransactionEtcType(transactionEtcType);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    final List<modelTransacation.TransactionAPI> transactions =
        await api.getTransactions();
    return transformer.makeModelTransactions(transactions);
  }

  @override
  Future<bool> updateTransactionEtcType(String id, type) async {
    await api.updateTransactionEtcType(
        id, transformer.makeModelTransactionEtcTypeAPI(type));
    return true;
  }
}
