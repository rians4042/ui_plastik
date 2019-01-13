import 'dart:core';

import 'package:meta/meta.dart';
import 'package:Recet/domains/item/model/dto/item-category.dart';
import 'package:Recet/domains/item/model/dto/item-unit.dart';
import 'package:Recet/domains/item/model/dto/item.dart';
import 'package:Recet/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Recet/app.dart';

class ItemFormState extends Model {
  String _errName;
  bool _loading;
  String _name;
  String _itemCategoryId;
  String _unitId;
  List<ItemUnit> _itemUnits;
  List<ItemCategory> _itemCategories;
  ItemService itemService;

  ItemFormState({@required this.itemService}) {
    _loading = false;
    _itemUnits = [];
    _itemCategories = [];
  }

  bool get loading => _loading;
  String get name => _name;
  String get errName => _errName;
  String get itemCategoryId => _itemCategoryId;
  String get unitId => _unitId;

  List<ItemUnit> get itemUnits => _itemUnits;
  bool get loadingItemUnits => _itemUnits.length < 1;

  List<ItemCategory> get itemCategories => _itemCategories;
  bool get loadingItemCategories => _itemCategories.length < 1;

  Future<void> getInitialData(String id,
      {Function onSuccess, Function(String message) onError}) async {
    try {
      if (_itemCategories.length < 1 && _itemUnits.length < 1) {
        _loading = true;
        notifyListeners();

        List<dynamic> response;
        if (id == null) {
          response = await Future.wait(
              [itemService.getItemCategories(), itemService.getItemUnits()]);
        } else {
          // conditional when the user at editing mode
          response = await Future.wait([
            itemService.getItemCategories(),
            itemService.getItemUnits(),
            itemService.getItemDetail(id),
          ]);
        }

        Item _item;
        _itemUnits = response[1];
        _itemCategories = response[0];

        // conditional when the user at editing mode
        if (id != null) {
          _item = (response[2] as Item);
          _name = _item.name;
          _unitId = _item.unitId;
          _itemCategoryId = _item.itemCategoryId;
        } else {
          _unitId = (response[1][0] as ItemUnit).id;
          _itemCategoryId = (response[0][0] as ItemCategory).id;
        }

        _loading = false;
        notifyListeners();

        onSuccess(_item);
      }
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addOrUpdateItems(
    String id, {
    Function onSuccess,
    Function(String message) onError,
  }) async {
    try {
      if (_validate()) {
        _loading = true;
        notifyListeners();

        if (id == null) {
          await itemService.createItem(
            Item(
              name: _name,
              itemCategoryId: _itemCategoryId,
              unitId: _unitId,
            ),
          );
        } else {
          await itemService.updateItem(
            id,
            Item(
              name: _name,
              itemCategoryId: _itemCategoryId,
              unitId: _unitId,
            ),
          );
        }

        _loading = false;
        notifyListeners();

        onSuccess();
      }
    } catch (e) {
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> deleteItem(id,
      {Function onSuccess, Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      await itemService.deleteItem(id);

      _loading = false;
      notifyListeners();

      onSuccess();
    } catch (e) {
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  bool _validate() {
    if (_name != '') {
      return true;
    }

    _errName = 'Nama tidak boleh kosong';
    notifyListeners();
    return false;
  }

  void onChangeName(String name) {
    _name = name;
    _errName = null;
    notifyListeners();
  }

  void onChangeUnitId(String id) {
    _unitId = id;
    notifyListeners();
  }

  void onChangeCategoryId(String id) {
    _itemCategoryId = id;
    notifyListeners();
  }
}
