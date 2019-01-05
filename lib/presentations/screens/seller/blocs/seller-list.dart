import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/screens/seller/states/seller-list.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class SellerListBloc implements BaseBloc {
  SellerListState seller;
  BehaviorSubject<SellerListState> _stateSeller;
  ActorService actorService;

  SellerListBloc({@required this.actorService}) {
    seller = SellerListState.empty();
    _stateSeller =
        BehaviorSubject<SellerListState>(seedValue: SellerListState.empty());
  }

  Stream<SellerListState> get sellers => _stateSeller.stream;

  Future<void> fetchSellers({Function(String message) onError}) async {
    try {
      if (_stateSeller.stream.value == null ||
          _stateSeller.stream.value.count < 1) {
        _stateSeller.sink.add(seller..changeLoading(true));

        final List<Seller> _sellers = await actorService.getSellers();

        _stateSeller.sink.add(seller..changeLoading(false));
        _stateSeller.sink.add(seller..addSellers(_sellers));
      }
    } catch (e) {
      _stateSeller.sink.addError(seller..changeLoading(false));
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  @override
  void dispose() {
    _stateSeller?.close();
  }
}
