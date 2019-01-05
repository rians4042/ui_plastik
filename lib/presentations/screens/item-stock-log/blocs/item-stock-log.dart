import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/report/model/dto/item-stock-log.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:plastik_ui/presentations/screens/item-stock-log/states/items-stock-log.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class ItemStockLogBloc implements BaseBloc {
  ItemStockLogBloc({@required this.itemStockLogService}) {
    _itemStockLogState = ItemStockLogState.empty();
    _statesItemStockLog =
        BehaviorSubject<ItemStockLogState>(seedValue: _itemStockLogState);
  }

  Stream<ItemStockLogState> get itemStockLog => _statesItemStockLog.stream;

  ReportService itemStockLogService;
  ItemStockLogState _itemStockLogState;
  BehaviorSubject<ItemStockLogState> _statesItemStockLog;

  Future<void> fetchInitilData({Function(String message) onError}) async {
    try {
      if (_statesItemStockLog.stream.value.data.length == 0) {
        _statesItemStockLog.sink.add(_itemStockLogState..onChangeError(false));
        _statesItemStockLog.sink.add(_itemStockLogState..onChangeLoading(true));

        List<ItemStockLog> _itemStockLogs =
            await itemStockLogService.getItemStockLogs();

        _statesItemStockLog.sink
            .add(_itemStockLogState..onChangeLoading(false));
        _statesItemStockLog.sink
            .add(_itemStockLogState..onAddData(_itemStockLogs));
      }
    } catch (e) {
      _statesItemStockLog.sink.add(_itemStockLogState..onChangeLoading(false));
      _statesItemStockLog.sink.add(_itemStockLogState..onChangeError(true));
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  @override
  void dispose() {
    _statesItemStockLog?.close();
  }
}
