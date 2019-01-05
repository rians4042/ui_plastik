import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/screens/home-tab.dart';
import 'package:plastik_ui/presentations/screens/item/screens/item-form.dart';
import 'package:plastik_ui/presentations/screens/item/screens/item-list.dart';
import 'package:plastik_ui/presentations/screens/seller/screens/seller-form.dart';
import 'package:plastik_ui/presentations/screens/seller/screens/seller-list.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-form.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-list.dart';
import 'package:plastik_ui/presentations/screens/transaction-etc/screens/transaction-etc-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/screens/transaction-in-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/screens/transaction-out-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/screens/transaction-type-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/screens/transaction-type-list.dart';

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
  };
}
