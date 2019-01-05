import 'dart:core';

import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/model/dto/item-unit.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/presentations/shared/widgets/add-button.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class ItemFormState extends Model {
  String _errName;
  bool _loading;
  String _name;
  String _itemCategoryId;
  String _unitId;
  List<ItemUnit> _itemUnits;
  List<ItemCategory> _itemCategories;

  ItemFormState() {
    _errName = '';
    _loading = false;
    _name = '';
    _itemCategoryId = '';
    _unitId = '';
    _itemCategories = [];
    _itemUnits = [];
  }

  bool get loading => _loading;
  String get name => _name;
  String get errName => _errName;
  String get itemCategoryId => _itemCategoryId;
  String get unitId => _unitId;
  List<ItemUnit> get itemUnit => _itemUnits;
  List<ItemCategory> get itemCategories => _itemCategories;

  Future<void> getInitialData({Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      List<dynamic> results = await Future.wait([
        (getIt<ItemService>() as ItemService).getItemCategories(),
        (getIt<ItemService>() as ItemService).getItemUnits()
      ]);
      _itemCategories = results[0];
      _itemCategoryId = results[1];

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> addOrUpdateItems(String id,
      {Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> onChangeName(String name) async {}

  void onChangeUnit(String id) {
    _unitId = id;
    notifyListeners();
  }

  void onChangeCategory(String id) {
    _itemCategoryId = id;
    notifyListeners();
  }
}
