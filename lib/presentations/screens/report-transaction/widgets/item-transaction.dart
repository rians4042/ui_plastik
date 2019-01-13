import 'package:flutter/material.dart';
import 'package:Recet/helpers/number/format-currency.dart';
import 'package:Recet/values/colors.dart';

class ItemTransaction extends StatelessWidget {
  ItemTransaction({
    @required this.amount,
    @required this.typeName,
    @required this.createdAt,
    @required this.onTap,
  });

  final int amount;
  final String typeName;
  final String createdAt;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: GREY_COLOR,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  typeName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tanggal : $createdAt',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              formatCurrency(amount, prefix: 'Rp. '),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
