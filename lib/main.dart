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
    routes: <String, WidgetBuilder>{
      '/itemacategory': (BuildContext contex) => new ItemCategory()
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final List<Example> examples = [
  Example(
    onPress: (BuildContext context) {
      return () {
        Navigator.pushNamed(context, '/category');
      };
    },
    icon: Icon(
      Icons.kitchen,
      size: 40.0,
    ),
    label: Text("Katergori"),
  ),
  Example(
    onPress: (BuildContext context) {
      return () {
        Navigator.pushNamed(context, '/itemacategory');
      };
    },
    icon: Icon(
      Icons.receipt,
      size: 40.0,
    ),
    label: Text("Item"),
  ),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Plastik"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: Text("hallo@gmail.com"),
              accountName: Text("suparman"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.ytimg.com/vi/qE9lgnBaIUg/maxresdefault.jpg"),
              ),
            ),
            new ListTile(
              title: new Text("Retail"),
              trailing: new Icon(Icons.content_copy),
            ),
            new ListTile(
              title: new Text("Suplier"),
              trailing: new Icon(Icons.donut_small),
              // contentPadding: EdgeInsets.only(left: 50.0, right: 15.0),
            ),
            new ListTile(
              title: new Text("Produksi"),
              trailing: new Icon(Icons.toys),
            )
          ],
        ),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: examples.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: examples[index].onPress(context),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100],
                    blurRadius: 7.0,
                  )
                ]),
                margin: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    examples[index].icon,
                    examples[index].label,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
