import 'package:flutter/material.dart';

class DropdownCustom<T> extends StatelessWidget {
  final bool loading;
  final T initialData;
  final T value;
  final bool isExpanded;
  final Function(T data) onChanged;
  final List<DropdownMenuItem> items;
  final String label;

  DropdownCustom({
    @required this.loading,
    @required this.items,
    @required this.onChanged,
    @required this.initialData,
    @required this.value,
    @required this.label,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 4),
          child: Text(label),
        ),
        DropdownButton<T>(
          isExpanded: isExpanded,
          items: loading
              ? <DropdownMenuItem<T>>[
                  DropdownMenuItem(
                    child: Text(''),
                    value: initialData,
                  )
                ]
              : items,
          onChanged: onChanged,
          value: loading ? initialData : value,
        ),
      ],
    );
  }
}
