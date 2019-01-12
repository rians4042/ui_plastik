import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class InputPickerDateTime extends StatelessWidget {
  InputPickerDateTime({
    @required this.label,
    @required this.value,
    @required this.onChanged,
  });

  final String label;
  final Function onChanged;
  final DateTime value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: DateTimePickerFormField(
        format: DateFormat("yyyy-MM-dd HH:mm:ss"),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        textAlign: TextAlign.start,
        resetIcon: Icons.close,
        initialValue: value,
      ),
    );
  }
}
