import 'package:flutter/material.dart';
import 'package:plastik_ui/helpers/number/format-currency.dart';
import 'package:plastik_ui/values/colors.dart';

class ItemTransactionOutDetailsForm extends StatelessWidget {
  final String itemName;
  final int qty;
  final double amount;
  final Function onDelete;
  final Function onEdit;

  ItemTransactionOutDetailsForm({
    @required this.itemName,
    @required this.qty,
    @required this.amount,
    @required this.onDelete,
    @required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: GREY_COLOR,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                itemName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Jumlah: $qty',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                'Total Harga: ${formatCurrency(amount)}',
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: RawMaterialButton(
                  onPressed: onEdit,
                  child: Icon(
                    Icons.edit,
                    color: WHITE_COLOR,
                    size: 18.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: PRIMARY_COLOR,
                ),
              ),
              Container(
                width: 36.0,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: RawMaterialButton(
                  onPressed: onDelete,
                  child: Icon(
                    Icons.close,
                    color: WHITE_COLOR,
                    size: 18.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: RED_COLOR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
