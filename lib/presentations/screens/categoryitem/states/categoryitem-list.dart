import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class CategoryItemListState extends Model {
  bool _loading;
  List<ItemCategory> _items;

  CategoryItemListState() {
    _loading = false;
    _items = [];
  }

  bool get loading => _loading;
  int get count => _items.length;
  List<ItemCategory> get items => _items;

  @override
  Future<void> fetchingItems({Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();

      final List<ItemCategory> items =
          await (getIt<ItemService>() as ItemService).getItemCategories();

      _items = items;
      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }
}
