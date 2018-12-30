import 'package:plastik_ui/domains/transaction/model/api/transaction-detail.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-etc.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-in.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction-out.dart';
import 'package:plastik_ui/domains/transaction/model/api/transaction.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-in.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-out.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction.dart';
import 'package:plastik_ui/helpers/datetime/datetime.dart';

abstract class TransactionTransformer {
  List<Transaction> makeModelTransactions(List<TransactionAPI> transactions);
  TransactionDetail makeModelTransactionDetail(
      TransactionDetailAPI transaction);
  List<TransactionEtcType> makeModelTransactionEtcTypes(
      List<TransactionEtcTypeAPI> transactionEtcType);
  TransactionEtcType makeModelTransactionEtcType(
      TransactionEtcTypeAPI transactionEtcType);
  TransactionEtcTypeAPI makeModelTransactionEtcTypeAPI(
      TransactionEtcType transactionEtcType);
  TransactionInAPI makeModelTransactionInAPI(TransactionIn transactionIn);
  TransactionOutAPI makeModelTransactionOutAPI(TransactionOut transactionOut);
  TransactionEtcAPI makeModelTransactionEtcAPI(TransactionEtc transactionEtc);
}

class TransactionTransformerImplementation implements TransactionTransformer {
  DateTimeCustom datetime;
  TransactionTransformerImplementation() {
    datetime = DateTimeCustomImplementation();
  }

  @override
  TransactionDetail makeModelTransactionDetail(
      TransactionDetailAPI transaction) {
    return TransactionDetail(
      id: transaction.id,
      amount: transaction.amount,
      images: transaction.images
          .map((img) => TransactionImage(
                id: img.id,
                image: img.image,
              ))
          .toList(),
      details: transaction.details
          .map((detail) => TransactionItemDetail(
              id: detail.id,
              amount: detail.amount,
              itemId: detail.itemId,
              itemName: detail.itemName,
              qty: detail.qty))
          .toList(),
      createdAt: datetime.create(
          transaction.createdAt, DateTimeCustomImplementation.DATEANDTIME),
      note: transaction.note,
      sellerId: transaction.sellerId,
      sellerName: transaction.sellerName,
      supplierId: transaction.supplierId,
      supplierName: transaction.supplierName,
      transactionEtcId: transaction.transactionEtcId,
      transactionEtcTypeName: transaction.transactionEtcTypeName,
      transactionInId: transaction.transactionInId,
      transactionOutId: transaction.transactionOutId,
      type: transaction.type,
      typeName: transaction.typeName,
    );
  }

  @override
  TransactionEtcAPI makeModelTransactionEtcAPI(TransactionEtc transactionEtc) {
    return TransactionEtcAPI(
      type: transactionEtc.type,
      amount: transactionEtc.amount,
      note: transactionEtc.note,
      images: transactionEtc.images,
    );
  }

  @override
  TransactionEtcType makeModelTransactionEtcType(
      TransactionEtcTypeAPI transactionEtcType) {
    return TransactionEtcType(
      id: transactionEtcType.id,
      name: transactionEtcType.name,
      createdAt: datetime.create(transactionEtcType.createdAt,
          DateTimeCustomImplementation.DATEANDTIME),
    );
  }

  @override
  TransactionEtcTypeAPI makeModelTransactionEtcTypeAPI(
      TransactionEtcType transactionEtcType) {
    return TransactionEtcTypeAPI(
      id: transactionEtcType.id,
      name: transactionEtcType.name,
      createdAt: datetime.create(transactionEtcType.createdAt,
          DateTimeCustomImplementation.DATEANDTIME),
    );
  }

  @override
  List<TransactionEtcType> makeModelTransactionEtcTypes(
      List<TransactionEtcTypeAPI> transactionEtcType) {
    return transactionEtcType
        .map(
          (trx) => TransactionEtcType(
                id: trx.id,
                name: trx.name,
                createdAt: datetime.create(
                    trx.createdAt, DateTimeCustomImplementation.DATEANDTIME),
              ),
        )
        .toList();
  }

  @override
  TransactionInAPI makeModelTransactionInAPI(TransactionIn transactionIn) {
    return TransactionInAPI(
      note: transactionIn.note,
      details: transactionIn.details
          .map((trx) => TransactionItemDetailAPI(
                id: trx.id,
                itemId: trx.itemId,
                itemName: trx.itemName,
                qty: trx.qty,
                amount: trx.amount,
              ))
          .toList(),
      supplierId: transactionIn.supplierId,
      images: transactionIn.images,
    );
  }

  @override
  TransactionOutAPI makeModelTransactionOutAPI(TransactionOut transactionOut) {
    return TransactionOutAPI(
      sellerId: transactionOut.sellerId,
      details: transactionOut.details
          .map((trx) => TransactionItemDetailAPI(
              id: trx.id,
              itemId: trx.itemId,
              itemName: trx.itemName,
              qty: trx.qty,
              amount: trx.amount))
          .toList(),
      images: transactionOut.images,
      note: transactionOut.note,
    );
  }

  @override
  List<Transaction> makeModelTransactions(List<TransactionAPI> transactions) {
    return transactions
        .map(
          (trx) => Transaction(
                id: trx.id,
                amount: trx.amount,
                note: trx.note,
                type: trx.type,
                typeName: trx.typeName,
                createdAt: datetime.create(
                    trx.createdAt, DateTimeCustomImplementation.DATEANDTIME),
              ),
        )
        .toList();
  }
}
