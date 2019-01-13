import 'package:Recet/domains/report/model/api/item-stock-log.dart';
import 'package:Recet/domains/report/model/api/transaction-detail.dart';
import 'package:Recet/domains/report/model/api/transaction.dart';
import 'package:Recet/domains/report/model/dto/item-stock-log.dart';
import 'package:Recet/domains/report/model/dto/transaction-detail.dart';
import 'package:Recet/domains/report/model/dto/transaction.dart';
import 'package:Recet/helpers/datetime/datetime.dart';

abstract class ReportTransformer {
  List<ItemStockLog> makeModelGetItemStockLogs(List<ItemStockLogAPI> items);
  TransactionDetail makeModelTransactionDetail(
      TransactionDetailAPI transaction);
  List<Transaction> makeModelTransactions(List<TransactionAPI> transactions);
}

class ReportTransformerImplementation implements ReportTransformer {
  DateTimeCustom datetime;
  ReportTransformerImplementation() {
    datetime = DateTimeCustomImplementation();
  }

  @override
  List<ItemStockLog> makeModelGetItemStockLogs(List<ItemStockLogAPI> items) {
    return items
        .map(
          (item) => ItemStockLog(
                itemId: item.itemId,
                itemName: item.itemName,
                qty: item.qty,
                unitName: item.unitName,
              ),
        )
        .toList();
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
