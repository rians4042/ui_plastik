import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Recet/values/colors.dart';

class ItemHome extends StatelessWidget {
  final String label;
  final String assetPath;
  final Function onPress;

  ItemHome({
    @required this.label,
    @required this.assetPath,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: WHITE_COLOR,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                assetPath,
                width: 36,
                height: 36,
              ),
              margin: EdgeInsets.only(bottom: 6),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
