import 'package:Recet/domains/report/model/api/transaction-detail.dart';
import 'package:Recet/domains/transaction/model/api/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/model/api/transaction-etc.dart';
import 'package:Recet/domains/transaction/model/api/transaction-in.dart';
import 'package:Recet/domains/transaction/model/api/transaction-out.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-in.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-out.dart';
import 'package:Recet/helpers/datetime/datetime.dart';

abstract class TransactionTransformer {
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
}
