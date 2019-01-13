import 'package:flutter/material.dart';
import 'package:Recet/values/colors.dart';

class AddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: RaisedButton(
        color: PRIMARY_COLOR,
        child: Text(
          'Tambah',
          style: TextStyle(color: WHITE_COLOR),
        ),
      ),
    );
  }
}
