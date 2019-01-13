import 'package:meta/meta.dart';
import 'package:Recet/app.dart';
import 'package:Recet/domains/item/model/dto/item.dart';
import 'package:Recet/domains/item/service/item.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemListState extends Model {
  bool _error;
  bool _loading;
  List<Item> _items;
  ItemService itemService;

  ItemListState({@required this.itemService}) {
    _items = [];
    _error = false;
    _loading = false;
  }

  bool get loading => _loading;
  bool get error => _error;
  int get count => _items.length;
  List<Item> get items => _items;

  Future<void> fetchingItems({Function(String message) onError}) async {
    try {
      if (_items.length < 1) {
        _error = false;
        _loading = true;
        notifyListeners();

        final List<Item> items = await itemService.getItems();

        _items = items;
        _loading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = true;
      _loading = false;
      notifyListeners();

      onError(e?.message ?? 'Terjadi kesalahan pada server');
    }
  }
}
