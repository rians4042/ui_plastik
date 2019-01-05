import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plastik_ui/values/colors.dart';

class ButtonLoading extends StatelessWidget {
  ButtonLoading({
    @required this.child,
    @required this.loading,
    @required this.onPress,
    @required this.disabled,
    @required this.color,
  });

  final Color color;
  final Widget child;
  final bool disabled;
  final bool loading;
  final Function onPress;

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
      onPressed: disabled ? null : onPress,
    );
  }
}
