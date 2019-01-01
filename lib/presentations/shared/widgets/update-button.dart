import 'package:flutter/material.dart';

class UpdateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      //onPressed: subtractNumbers,
      textTheme: ButtonTextTheme.accent,
      textColor: Colors.white,
      color: Colors.blueAccent,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "Update",
      ),
    );
  }
}
