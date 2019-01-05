import 'package:flutter/material.dart';
import 'package:plastik_ui/values/colors.dart';

class ItemTransactionInDetailsForm extends StatelessWidget {
  final String itemName;
  final int qty;
  final int amount;
  final Function onDelete;
  final Function onEdit;

  ItemTransactionInDetailsForm({
    @required this.itemName,
    @required this.qty,
    @required this.amount,
    @required this.onDelete,
    @required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              itemName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Jumlah: $qty Harga /Satuan: $amount',
              style: TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            new RawMaterialButton(
              onPressed: () {},
              child: new Icon(
                Icons.edit,
                color: PRIMARY_COLOR,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
            ),
            new RawMaterialButton(
              onPressed: () {},
              child: new Icon(
                Icons.pause,
                color: RED_COLOR,
                size: 35.0,
              ),
              shape: new CircleBorder(),
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
            ),
          ],
        ),
      ],
    );
  }
}
