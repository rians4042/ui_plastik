import 'package:flutter/material.dart';
import 'package:Recet/values/colors.dart';

class UpdateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: RaisedButton(
        onPressed: () {},
        color: PRIMARY_COLOR,
        child: Text(
          'Simpan',
          style: TextStyle(color: WHITE_COLOR),
        ),
      ),
    );
  }
}
