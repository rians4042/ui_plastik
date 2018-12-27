import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plastik_ui/helpers/injector/injector.dart';
import 'package:plastik_ui/routes/routes.dart';

GetIt getIt = GetIt();

class App extends StatelessWidget {
  App() {
    injector(getIt);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: initialRoute(),
    );
  }
}
