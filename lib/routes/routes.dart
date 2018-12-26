import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/home/home.dart';

typedef Widget ValueRouteType(BuildContext ctx);

Map<String, ValueRouteType> initialRoute() {
  return {
    "/": (BuildContext ctx) => HomeTabbarNav(),
  };
}
