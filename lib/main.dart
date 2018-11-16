import 'package:flutter/material.dart';

void main(){
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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Pabrik Plastik"),),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile( 
              title: new Text("Retail"),
              trailing: new Icon(Icons.content_copy),
            ),
            new ListTile(
              title: new Text("Suplier"),
              trailing: new Icon(Icons.donut_small),
              contentPadding: EdgeInsets.only(left: 50.0, right: 15.0),
            ),

            new ListTile(
              title: new Text("Produksi"),
              trailing: new Icon(Icons.toys),
            )
          ],
        ),
      ),
      body: new Container(),
    );
  }
}
