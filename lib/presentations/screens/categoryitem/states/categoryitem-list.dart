import 'package:meta/meta.dart';
import 'package:Recet/domains/item/model/dto/item-category.dart';
import 'package:Recet/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryItemListState extends Model {
  bool _loading;
  bool _error;
  List<ItemCategory> _items;
  ItemService itemService;

  CategoryItemListState({@required this.itemService}) {
    _items = [];
    _error = false;
    _loading = false;
  }

  bool get loading => _loading;
  int get count => _items.length;
  List<ItemCategory> get items => _items;
  bool get error => _error;

  Future<void> fetchingItems({Function(String message) onError}) async {
    try {
      if (_items.length == 0) {
        _loading = true;
        _error = false;
        notifyListeners();

        final List<ItemCategory> items = await itemService.getItemCategories();

        _items = items;
        _loading = false;
        notifyListeners();
      }
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();

      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }
}
