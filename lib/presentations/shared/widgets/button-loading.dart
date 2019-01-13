import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Recet/values/colors.dart';

class ButtonLoading extends StatelessWidget {
  ButtonLoading({
    @required this.child,
    this.loading = false,
    @required this.onPressed,
    this.disabled = false,
    @required this.color,
  });

  final Color color;
  final Widget child;
  final bool disabled;
  final bool loading;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      child: loading
          ? SpinKitThreeBounce(
              color: WHITE_COLOR,
              size: 16,
            )
          : child,
      onPressed: disabled || loading ? null : onPressed,
    );
  }
}
