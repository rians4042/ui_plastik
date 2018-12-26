import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Graphic extends StatelessWidget {
  final List<String> names = ["äzhar", "rian"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width: double.infinity,
      child: PageView.builder(
        itemCount: names.length,
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
    );
  }
}
