import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/screens/supplier/states/supplier-list.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:plastik_ui/app.dart';

class SupplierListBloc implements BaseBloc {
  SupplierListState supplier;
  BehaviorSubject<SupplierListState> _stateSupplier;

  SupplierListBloc() {
    supplier = SupplierListState.empty();
    _stateSupplier = BehaviorSubject<SupplierListState>(
        seedValue: SupplierListState.empty());
  }

  Stream<SupplierListState> get suppliers => _stateSupplier.stream;

  Future<void> fetchSuppliers({Function(String message) onError}) async {
    try {
      _stateSupplier.sink.add(supplier..changeLoading(true));

      final List<Supplier> _suppliers =
          await (getIt<ActorService>() as ActorService).getSuppliers();

      _stateSupplier.sink.add(supplier..changeLoading(false));
      _stateSupplier.sink.add(supplier..addSuppliers(_suppliers));
    } catch (e) {
      _stateSupplier.sink.addError(supplier..changeLoading(false));
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  @override
  void dispose() {
    _stateSupplier?.close();
  }
}
