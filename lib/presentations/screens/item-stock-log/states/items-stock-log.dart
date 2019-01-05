import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';

class ItemStockLogState {
  bool _loading;
  bool _error;
  List<ItemStockLog> _data;

  bool get loading => _loading;
  bool get error => _error;
  List<ItemStockLog> get data => _data;

  ItemStockLogState.empty() {
    _data = [];
    _error = false;
    _loading = false;
  }

  void onChangeLoading(bool _newLoading) {
    _loading = _newLoading;
  }

  void onChangeError(bool _newError) {
    _error = _newError;
  }

  void onAddData(List<ItemStockLog> _newData) {
    _data = _newData;
  }
}
