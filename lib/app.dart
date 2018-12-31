import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plastik_ui/helpers/injector/injector.dart';
import 'package:plastik_ui/presentations/screens/home/screens/home-tab.dart';
import 'package:plastik_ui/routes/routes.dart';
import 'package:plastik_ui/values/colors.dart';

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
