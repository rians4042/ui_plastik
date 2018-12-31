import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastik_ui/values/colors.dart';

class ErrorNotification extends StatelessWidget {
  final Function onRetry;

  ErrorNotification({
    @required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/svg/020-conflict.svg',
          width: 100,
          height: 100,
        ),
        Container(
          margin: EdgeInsets.only(
            top: 8,
          ),
          child: RaisedButton(
            onPressed: onRetry,
            child: Text('Coba Lagi'),
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}
