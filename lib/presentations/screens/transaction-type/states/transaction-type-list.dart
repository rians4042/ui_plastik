import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';

class TransactionTypeListState {
  bool _loading;
  List<TransactionEtcType> _types;

  bool get loading => _loading;
  List<TransactionEtcType> get types => _types;
  int get count => _types.length;

  void changeLoading(bool _newLoading) {
    _loading = _newLoading;
  }

  void addTypes(List<TransactionEtcType> _newTypes) {
    _types = _newTypes;
  }

  TransactionTypeListState.empty() {
    _loading = false;
    _types = [];
  }
}
