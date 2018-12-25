import 'package:flutter/material.dart';
import 'package:plastik_ui/screens/item-product/model/item-product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;
//import 'package:example/buildin_transformers.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final List<String> names = ["äzhar", "rian"];

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
    label: Text("Category"),
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
    label: Text("Item Category"),
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
          child: Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: PageView.builder(
                itemCount: names.length,
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 370.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.grey[300],
                    child: Text(names[index]),
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
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
            )
          ]),
        ));
  }
}
