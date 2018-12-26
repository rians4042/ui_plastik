import 'package:flutter/material.dart';

typedef Function OnPressType(BuildContext ctx);

class Example {
  Widget icon;
  Widget label;
  OnPressType onPress;

  Example({
    @required this.icon,
    @required this.label,
    @required this.onPress,
  });
}
