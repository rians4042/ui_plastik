import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/actor.dart';
import 'package:plastik_ui/presentations/screens/home/widgets/graphics.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: <Widget>[
            Graphic(),
            Container(
              height: 00,
            ),
            Actor(),
          ],
        ),
      ),
    );
  }
}
