import 'package:meta/meta.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/service/transaction.dart';
import 'package:Recet/presentations/screens/transaction-type/states/transaction-type-list.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class TransactionTypeListBloc implements BaseBloc {
  final TransactionService transactionService;
  TransactionTypeListState _transactionTypeList;
  BehaviorSubject<TransactionTypeListState> _statesTransactionTypeList;

  Stream<TransactionTypeListState> get transactionTypeList =>
      _statesTransactionTypeList.stream;

  TransactionTypeListBloc({@required this.transactionService}) {
    _transactionTypeList = TransactionTypeListState.empty();
    _statesTransactionTypeList = BehaviorSubject<TransactionTypeListState>(
        seedValue: _transactionTypeList);
  }

  Future<void> fetchTransactionTypes({Function(String message) onError}) async {
    try {
      _statesTransactionTypeList.sink
          .add(_transactionTypeList..changeLoading(true));

      final List<TransactionEtcType> _newTransactionTypes =
          await transactionService.getTransactionEtcTypes();

      _statesTransactionTypeList.sink
          .add(_transactionTypeList..changeLoading(false));
      _statesTransactionTypeList.sink
          .add(_transactionTypeList..addTypes(_newTransactionTypes));
    } catch (e) {
      _statesTransactionTypeList.sink
          .addError(_transactionTypeList..changeLoading(true));
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  @override
  void dispose() {
    _statesTransactionTypeList?.close();
  }
}
