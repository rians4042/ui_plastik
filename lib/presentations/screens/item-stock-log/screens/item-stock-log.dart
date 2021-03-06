import 'package:flutter/material.dart';
import 'package:Recet/domains/report/service/report.dart';
import 'package:Recet/presentations/screens/item-stock-log/blocs/item-stock-log.dart';
import 'package:Recet/app.dart';
import 'package:Recet/presentations/screens/item-stock-log/states/items-stock-log.dart';
import 'package:Recet/presentations/screens/item-stock-log/widgets/header-item-stock-log.dart';
import 'package:Recet/presentations/screens/item-stock-log/widgets/item.dart';
import 'package:Recet/presentations/shared/widgets/error-notification.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/values/type_list.dart';

class ItemStockLog extends StatefulWidget {
  static String routeName = '/itemstock';

  @override
  State<StatefulWidget> createState() => _ItemStockLogState();
}

class _ItemStockLogState extends State<ItemStockLog> {
  _ItemStockLogState() {
    _itemStockLogBloc =
        ItemStockLogBloc(itemStockLogService: getIt<ReportService>());
  }

  ItemStockLogBloc _itemStockLogBloc;

  @override
  void dispose() {
    _itemStockLogBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stok Barang'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchData() {
            _itemStockLogBloc.fetchInitilData(onError: (String message) {
              Scaffold.of(ctx).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            });
          }

          fetchData();
          return StreamBuilder<ItemStockLogState>(
            stream: _itemStockLogBloc.itemStockLog,
            builder: (BuildContext ctx,
                AsyncSnapshot<ItemStockLogState> itemStockLogSnapshot) {
              if (!itemStockLogSnapshot.hasData &&
                  itemStockLogSnapshot.data.loading &&
                  !itemStockLogSnapshot.data.error) {
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: FluttonShimmering.list(
                    count: 10,
                    countLine: 5,
                    widthLine: MediaQuery.of(context).size.width * 0.95,
                    lastWidthLine: 28,
                    heightLine: 6,
                    typeList: FluttonShimmeringTypeList.ITEM,
                  ),
                );
              }

              if (!itemStockLogSnapshot.data.loading &&
                  itemStockLogSnapshot.data.error) {
                return ErrorNotification(
                  onRetry: fetchData,
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: itemStockLogSnapshot.data.data.length + 1,
                itemBuilder: (BuildContext ctx, int index) {
                  if (index == 0) {
                    return HeaderItemStockLog();
                  }

                  return ItemFromItemStockLog(
                    number: index,
                    itemName:
                        itemStockLogSnapshot.data.data[index - 1].itemName,
                    unitName:
                        itemStockLogSnapshot.data.data[index - 1].unitName,
                    qty: itemStockLogSnapshot.data.data[index - 1].qty,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
