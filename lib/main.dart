import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/itemcategory/itemcategory.dart';
import 'package:plastik_ui/screens/item-product/model/item-product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;

void main() {
  runApp(new MaterialApp(
    title: "Pabrik_Plastik",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List userData;

  Future<String> ambildata() async {
    http.Response hasil = await http
        .get(Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"));

    this.setState(() {
      userData = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    // this.ambildata();
  }

  final List<String> names = ["äzhar", "rian"];
  // 2 data map / obj

  // final Map<String, dynamic> examples = {
  //   "name": "azhar prabudi",
  // };

  // examples["name"]

  // obj
  final List<Example> examples = [
    Example(
        icon: Icon(
          Icons.kitchen,
          size: 40.0,
        ),
        label: Text("Katergori")),
    Example(
        icon: Icon(
          Icons.receipt,
          size: 40.0,
        ),
        label: Text("Item")),
    Example(
        icon: Icon(
          Icons.people,
          size: 40.0,
        ),
        label: Text("Seller")),
    Example(icon: Icon(Icons.import_export, size: 40.0), label: Text("")),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("plastik"),
      ),
      body: ItemCategory(),
    );
  }
}
