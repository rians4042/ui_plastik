import 'package:flutter/material.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemListState extends Model {
  bool _loading;
  List<Item> _items;

  ItemListState() {
    _loading = false;
    _items = [];
  }

  bool get loading => _loading;
  int get count => _items.length;
  List<Item> get items => _items;

  @override
  Future<void> fetchingItems({Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      final List<Item> items =
          await (getIt<ItemService>() as ItemService).getItems();

      _items = items;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi kesalahan pada server');
    }
  }
}
