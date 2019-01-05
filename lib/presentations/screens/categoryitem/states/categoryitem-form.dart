import 'package:plastik_ui/domains/item/model/dto/item-unit.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryItemFormState extends Model {
  String _errName;
  bool _loading;
  String _name;
  String _unitId;
  List<ItemUnit> _itemUnits;

  CategoryItemForm() {
    _errName = '';
    _loading = false;
    _name = '';
    _unitId = '';
    _itemUnits = [];
  }

  bool get loading => _loading;
  String get name => _name;
  String get errName => _errName;
  List<ItemUnit> get itemUnit => _itemUnits;

  Future<void> getInitialData({Function(String message) onError}) async {
    try {
      _loading = true;
      notifyListeners();
    } catch (e) {}
  }
}
