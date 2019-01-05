import 'package:flutter/material.dart';
import 'package:plastik_ui/values/colors.dart';

class ItemFromItemStockLog extends StatelessWidget {
  final String itemName;
  final String unitName;
  final int qty;
  final int number;

  ItemFromItemStockLog({
    @required this.itemName,
    @required this.unitName,
    @required this.qty,
    @required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: GREY_COLOR,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 25,
                child: Text(number.toString()),
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(itemName),
              ),
            ],
          ),
          Text('${qty.toString()} ${unitName}'),
        ],
      ),
    );
  }
}
