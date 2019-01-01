import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/screens/home-tab.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-form.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-list.dart';

typedef Widget ValueRouteType(BuildContext ctx);

Map<String, ValueRouteType> initialRoute() {
  return {
    HomeTabbarNav.routeName: (BuildContext ctx) => HomeTabbarNav(),
    SupplierList.routeName: (BuildContext ctx) => SupplierList(),
    SupplierForm.routeName: (BuildContext ctx) => SupplierForm(),
  };
}
