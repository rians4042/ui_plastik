import 'package:flutter/material.dart';
import 'package:Recet/presentations/screens/home/screens/home-tab.dart';
import 'package:Recet/presentations/screens/item-stock-log/screens/item-stock-log.dart';
import 'package:Recet/presentations/screens/item/screens/item-form.dart';
import 'package:Recet/presentations/screens/item/screens/item-list.dart';
import 'package:Recet/presentations/screens/report-transaction/screens/report-transaction-detail.dart';
import 'package:Recet/presentations/screens/report-transaction/screens/report-transactions.dart';
import 'package:Recet/presentations/screens/seller/screens/seller-form.dart';
import 'package:Recet/presentations/screens/seller/screens/seller-list.dart';
import 'package:Recet/presentations/screens/supplier/screens/supplier-form.dart';
import 'package:Recet/presentations/screens/supplier/screens/supplier-list.dart';
import 'package:Recet/presentations/screens/transaction-etc/screens/transaction-etc-form.dart';
import 'package:Recet/presentations/screens/transaction-in/screens/transaction-in-form.dart';
import 'package:Recet/presentations/screens/transaction-out/screens/transaction-out-form.dart';
import 'package:Recet/presentations/screens/transaction-type/screens/transaction-type-form.dart';
import 'package:Recet/presentations/screens/transaction-type/screens/transaction-type-list.dart';

typedef Widget ValueRouteType(BuildContext ctx);

Map<String, ValueRouteType> initialRoute() {
  return {
    HomeTabbarNav.routeName: (BuildContext ctx) => HomeTabbarNav(),
    ItemList.routeName: (BuildContext ctx) => ItemList(),
    ItemForm.routeName: (BuildContext ctx) => ItemForm(),
    SupplierList.routeName: (BuildContext ctx) => SupplierList(),
    SupplierForm.routeName: (BuildContext ctx) => SupplierForm(),
    SellerList.routeName: (BuildContext ctx) => SellerList(),
    SellerForm.routeName: (BuildContext ctx) => SellerForm(),
    TransactionTypeList.routeName: (BuildContext ctx) => TransactionTypeList(),
    TransactionTypeForm.routeName: (BuildContext ctx) => TransactionTypeForm(),
    TransactionOutForm.routeName: (BuildContext ctx) => TransactionOutForm(),
    TransactionInForm.routeName: (BuildContext ctx) => TransactionInForm(),
    TransactionEtcForm.routeName: (BuildContext ctx) => TransactionEtcForm(),
    ItemStockLog.routeName: (BuildContext ctx) => ItemStockLog(),
    ReportTransaction.routeName: (BuildContext ctx) => ReportTransaction(),
    ReportTransactionDetail.routeName: (BuildContext ctx) =>
        ReportTransactionDetail(),
  };
}
