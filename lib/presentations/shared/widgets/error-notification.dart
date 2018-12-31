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
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/020-conflict.svg',
            width: 100,
            height: 100,
          ),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              margin: EdgeInsets.only(
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.refresh,
                    color: PRIMARY_COLOR,
                    size: 24,
                  ),
                  Text(
                    'Coba Lagi',
                    style: TextStyle(
                      fontSize: 24,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
