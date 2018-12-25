import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/home/home_ui.dart';
import 'package:plastik_ui/domain/itemcategory/itemcategory.dart';
import 'package:plastik_ui/domain/itemcategory/itemcategory.dart';
import 'package:plastik_ui/screens/item-product/model/item-product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;

void main() {
  runApp(new MaterialApp(
    title: "Pabrik_Plastik",
    home: new Main(),
    routes: <String, WidgetBuilder>{
      '/itemacategory': (BuildContext contex) => new ItemCategory(),
      '/category': (BuildContext contex) => new ItemCategory()
    },
  ));
}

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return new Home();
  }
}
