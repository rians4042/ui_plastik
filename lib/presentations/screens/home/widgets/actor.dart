import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example {
  Function onPress;
  Widget icon;
  Widget label;

  Example({
    @required this.onPress,
    @required this.icon,
    @required this.label,
  });
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
      size: 20.0,
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
      size: 20.0,
    ),
    label: Text("Item Category"),
  ),
];

class Actor extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: <Widget>[
        Text('Actors', style: TextStyle(fontSize: 30.0, color: Colors.black)),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: examples.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
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
        )
      ],
    );
  }
}
