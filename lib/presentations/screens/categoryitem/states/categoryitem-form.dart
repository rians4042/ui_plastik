import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/model/dto/item-unit.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class CategoryItemFormState extends Model {
  String _errName;
  bool _loading;
  String _name;
  String _unitId;
  List<ItemUnit> _itemUnits;
  String _itemCategoryId;
  ItemService itemService;

  CategoryItemForm() {
    _errName = '';
    _loading = false;
    _name = '';
  }

  String get itemCategoryId => _itemCategoryId;
  bool get loading => _loading;
  String get name => _name;
  String get errName => _errName;

  Future<void> getInitialData(String id,
      {Function onSuccess, Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      List<dynamic> response;
      if (id == null) {
        response = await Future.wait([
          itemService.getItemCategories(),
        ]);
      } else {
        response = await Future.wait([
          itemService.getItemCategories(),
          itemService.getItemCategoryDetail(id)
        ]);
      }

      ItemCategory _itemCategory;
      _itemCategory = response[0];

      if (id == null) {
        _itemCategory = (response[1] as ItemCategory);
        _name = _itemCategory.name;
      } else {}

      _loading = false;
      notifyListeners();

      onSuccess(_itemCategory);
    } catch (e) {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addOrUpdateCategories(
    String id, {
    Function onSuccess,
    Function(String message) onError,
  }) async {
    try {
      if (_validate()) {
        _loading = true;
        notifyListeners();

        if (id == null) {
          await (getIt<ItemService>() as ItemService).createItemCategory(
            ItemCategory(name: _name),
          );
        } else {
          await (getIt<ItemService>() as ItemService).updateItemCategory(
            id,
            ItemCategory(
              name: _name,
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

  Future<void> deleteCategory(id,
      {Function onSuccess, Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      await (getIt<ItemService>() as ItemService).deleteItemCategory(id);

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
}
//
