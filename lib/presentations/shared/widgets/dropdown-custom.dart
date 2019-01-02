import 'package:flutter/material.dart';

class DropdownCustom<T> extends StatelessWidget {
  final bool loading;
  final T initialData;
  final T value;
  final bool isExpanded;
  final Function(T data) onChanged;
  final List<DropdownMenuItem> items;

  DropdownCustom({
    @required this.loading,
    @required this.items,
    @required this.onChanged,
    @required this.initialData,
    @required this.value,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
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
    );
  }
}
