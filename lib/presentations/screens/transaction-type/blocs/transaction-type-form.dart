import 'package:meta/meta.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/service/transaction.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class TransactionTypeFormBloc implements BaseBloc {
  final TransactionService transactionService;
  BehaviorSubject<bool> _statesLoading;
  BehaviorSubject<String> _statesName;

  TransactionTypeFormBloc({@required this.transactionService}) {
    _statesLoading = BehaviorSubject<bool>(seedValue: false);
    _statesName = BehaviorSubject<String>();
  }

  Stream<bool> get loading => _statesLoading.stream;
  Stream<String> get name => _statesName.stream;

  Sink<String> get changeName => _statesName.sink;

  Future<void> fetchDetailTransactionType(String id,
      {Function(String message) onError,
      Function(TransactionEtcType transactionEtcType) onSuccess}) async {
    bool _isNullName = _statesName.stream.value == null;
    try {
      if (id != null && _isNullName) {
        final TransactionEtcType transactionType =
            await transactionService.getTransactionEtcTypeDetail(id);
        _statesName.sink.add(transactionType.name);
        onSuccess(transactionType);
      }
    } catch (e) {
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> addOrUpdateTransactionType(String id,
      {Function(String message) onError, Function onSuccess}) async {
    try {
      if (_validate()) {
        _statesLoading.sink.add(true);

        if (id == null) {
          await transactionService.createTransactionEtcType(TransactionEtcType(
            name: _statesName.stream.value,
          ));
        } else {
          await transactionService.updateTransactionEtcType(
              id,
              TransactionEtcType(
                name: _statesName.stream.value,
              ));
        }

        _statesLoading.sink.add(false);
        onSuccess();
      }
    } catch (e) {
      _statesLoading.sink.addError(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> deleteTransactionType(String id,
      {Function(String message) onError, Function onSuccess}) async {
    try {
      _statesLoading.sink.add(true);
      await transactionService.deleteTransactionEtcType(id);
      _statesLoading.sink.add(false);
      onSuccess();
    } catch (e) {
      _statesLoading.sink.addError(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  bool _validate() {
    bool validate = true;

    if (_statesName.stream.value == null || _statesName.stream.value == '') {
      validate = false;
      _statesLoading.sink.addError('Nama tidak boleh kosong');
    }

    return validate;
  }

  @override
  void dispose() {
    _statesLoading?.close();
    _statesName?.close();
  }
}
