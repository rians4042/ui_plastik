import 'package:flutter/material.dart';

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
  final List<String> names = ["äzhar", "rian"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pabrik Plastik"),
      ),
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
      body: Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: ListView.builder(
                itemCount: names.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 80.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.red,
                    child: Text(names[index]),
                  );
                },
              ),
            ),
            Expanded(
                child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this would produce 2 rows.
              crossAxisCount: 2,
              // Generate 100 Widgets that display their index in the List
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
