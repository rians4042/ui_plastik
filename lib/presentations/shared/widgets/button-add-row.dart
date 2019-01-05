import 'package:flutter/material.dart';
import 'package:plastik_ui/values/colors.dart';

class ButtonAddRow extends StatelessWidget {
  final Function onPress;

  ButtonAddRow({@required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.add_circle_outline,
            color: PRIMARY_COLOR,
          ),
          Text(
            'Tambah Detail (min 1)',
            style: TextStyle(
              color: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
