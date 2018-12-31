import 'package:plastik_ui/domains/report/model/api/item-stock-log.dart';
import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';

abstract class ReportTransformer {
  List<ItemStockLog> makeModelGetItemStockLogs(List<ItemStockLogAPI> items);
}

class ReportTransformerImplementation implements ReportTransformer {
  @override
  List<ItemStockLog> makeModelGetItemStockLogs(List<ItemStockLogAPI> items) {
    return items.map(
      (item) => ItemStockLog(
            itemId: item.itemId,
            itemName: item.itemName,
            qty: item.qty,
            unitName: item.unitName,
          ),
    );
  }
}
