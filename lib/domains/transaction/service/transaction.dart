import 'package:meta/meta.dart';
import 'package:Recet/domains/transaction/api/transaction.dart';
import 'package:Recet/domains/transaction/model/api/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-in.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-out.dart';
import 'package:Recet/domains/transaction/transform/transaction.dart';

abstract class TransactionService {
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
  Future<bool> updateTransactionEtcType(String id, type) async {
    await api.updateTransactionEtcType(
        id, transformer.makeModelTransactionEtcTypeAPI(type));
    return true;
  }
}
