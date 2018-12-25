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
      body: Center(
        child: Card(
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Container for graphic
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
              //container for transaction
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                child: Column(
                  children: <Widget>[],
                ),
              ),
              //container for item & category item
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
                        margin: const EdgeInsets.all(20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
