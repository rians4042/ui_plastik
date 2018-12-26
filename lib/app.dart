import 'package:flutter/material.dart';
import 'package:plastik_ui/routes/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: initialRoute(),
    );
  }
}
