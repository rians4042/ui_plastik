import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Recet/helpers/injector/injector.dart';
import 'package:Recet/presentations/screens/home/screens/home-tab.dart';
import 'package:Recet/routes/routes.dart';
import 'package:Recet/values/colors.dart';

GetIt getIt = GetIt();

class App extends StatelessWidget {
  App() {
    injector(getIt);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: PRIMARY_COLOR),
      routes: initialRoute(),
      initialRoute: HomeTabbarNav.routeName,
    );
  }
}
