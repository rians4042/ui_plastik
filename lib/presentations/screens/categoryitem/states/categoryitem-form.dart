import 'package:meta/meta.dart';
import 'package:Recet/domains/item/model/dto/item-category.dart';
import 'package:Recet/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:Recet/app.dart';

class CategoryItemFormState extends Model {
  String _errName;
  bool _loading;
  String _name;
  String _itemCategoryId;
  ItemService itemService;

  CategoryItemFormState({@required this.itemService}) {
    _loading = false;
  }

  String get itemCategoryId => _itemCategoryId;
  bool get loading => _loading;
  String get name => _name;
  String get errName => _errName;

  void getInitialData(String id,
      {Function onSuccess, Function(String message) onError}) async {
    try {
      if (id != null) {
        _loading = true;
        notifyListeners();

        ItemCategory _itemCategory =
            await itemService.getItemCategoryDetail(id);
        _name = _itemCategory.name;

        _loading = false;
        notifyListeners();
        onSuccess(_itemCategory);
      }
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
