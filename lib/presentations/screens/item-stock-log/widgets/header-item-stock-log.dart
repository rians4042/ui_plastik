import 'package:flutter/material.dart';
import 'package:Recet/values/colors.dart';

class HeaderItemStockLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      color: GREY_COLOR,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 25,
                child: Text(
                  'No.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(
                  'Nama',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Jumlah',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
