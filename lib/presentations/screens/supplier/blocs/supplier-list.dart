import 'package:meta/meta.dart';
import 'package:Recet/domains/actor/model/dto/supplier.dart';
import 'package:Recet/domains/actor/service/actor.dart';
import 'package:Recet/presentations/screens/supplier/states/supplier-list.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class SupplierListBloc implements BaseBloc {
  final ActorService actorService;
  SupplierListState supplier;
  BehaviorSubject<SupplierListState> _stateSupplier;

  SupplierListBloc({@required this.actorService}) {
    supplier = SupplierListState.empty();
    _stateSupplier = BehaviorSubject<SupplierListState>(
        seedValue: SupplierListState.empty());
  }

  Stream<SupplierListState> get suppliers => _stateSupplier.stream;

  Future<void> fetchSuppliers({Function(String message) onError}) async {
    try {
      if (_stateSupplier.stream.value == null ||
          _stateSupplier.stream.value.count < 1) {
        _stateSupplier.sink.add(supplier..changeLoading(true));

        final List<Supplier> _suppliers = await actorService.getSuppliers();

        _stateSupplier.sink.add(supplier..changeLoading(false));
        _stateSupplier.sink.add(supplier..addSuppliers(_suppliers));
      }
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
