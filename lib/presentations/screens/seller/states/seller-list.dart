import 'package:plastik_ui/domains/actor/model/dto/seller.dart';

class SellerListState {
  bool _loading;
  List<Seller> _sellers;

  bool get loading => _loading;
  List<Seller> get sellers => _sellers;
  int get count => _sellers?.length ?? 0;

  SellerListState.empty() {
    _loading = false;
    _sellers = [];
  }

  void addSellers(List<Seller> _newSellers) {
    _sellers = _newSellers;
  }

  void changeLoading(bool _newLoading) {
    _loading = _newLoading;
  }
}
