import 'package:Recet/domains/actor/model/dto/supplier.dart';

class SupplierListState {
  bool _loading;
  List<Supplier> _suppliers;

  bool get loading => _loading;
  List<Supplier> get suppliers => _suppliers;
  int get count => _suppliers?.length ?? 0;

  SupplierListState.empty() {
    _loading = false;
    _suppliers = [];
  }

  void addSuppliers(List<Supplier> _newSuppliers) {
    _suppliers = _newSuppliers;
  }

  void changeLoading(bool _newLoading) {
    _loading = _newLoading;
  }
}
