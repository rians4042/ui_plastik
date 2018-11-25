import 'package:flutter/material.dart';
import 'package:plastik_ui/screens/item-product/model/item-product.dart';

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
        //color: Colors.blue,
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
                    width: 370.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.grey[300],
                    child: Text(names[index]),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this would produce 2 rows.
                // crossAxisCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //crossAxisSpacing: 5.0,
                  //mainAxisSpacing: 0.0,
                ),
                // Generate 100 Widgets that display their index in the List
                itemCount: examples.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                      onTap: () {
                        print("kuda $index");
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey[100],
                              blurRadius: 7.0,
                            ),
                          ],
                          //border: Border.all(color: Colors.black38),
                        ),
                        margin: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            examples[index].icon,
                            examples[index].label,
                          ],
                        ),
                      ));
                },
                // itemBuilder: List.generate(4, (index) {
                //   return Center(
                //       child: GestureDetector(
                //           onTap: () {},
                //           child: Container(child: Icon(Icons.home))));
                // }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
