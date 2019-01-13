import 'package:flutter/material.dart';
import 'package:Recet/values/colors.dart';

class ItemRightArrow extends StatelessWidget {
  final String label;
  final Function onPress;

  ItemRightArrow({
    @required this.label,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: GREY_COLOR,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(label),
            Icon(
              Icons.arrow_forward_ios,
              color: GREY_COLOR,
            )
          ],
        ),
      ),
    );
  }
}
