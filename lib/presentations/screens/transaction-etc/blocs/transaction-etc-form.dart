import 'package:meta/meta.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:Recet/domains/transaction/model/dto/transaction-etc.dart';
import 'package:Recet/domains/transaction/service/transaction.dart';
import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class TransactionEtcFormBloc implements BaseBloc {
  TransactionEtcFormBloc({@required this.transactionService}) {
    _etcTypes = [];

    _statesNote = BehaviorSubject<String>();
    _statesAmount = BehaviorSubject<double>();
    _statesTypeId = BehaviorSubject<String>();
    _statesLoading = BehaviorSubject<bool>();
    _statesEtcTypes = BehaviorSubject<List<TransactionEtcType>>();
  }

  List<TransactionEtcType> _etcTypes;

  final TransactionService transactionService;
  BehaviorSubject<bool> _statesLoading;
  BehaviorSubject<String> _statesNote;
  BehaviorSubject<double> _statesAmount;
  BehaviorSubject<String> _statesTypeId;
  BehaviorSubject<List<TransactionEtcType>> _statesEtcTypes;

  Stream<bool> get loading => _statesLoading.stream;
  Stream<String> get note => _statesNote.stream;
  Stream<double> get amount => _statesAmount.stream;
  Stream<String> get type => _statesTypeId.stream;
  Stream<List<TransactionEtcType>> get types => _statesEtcTypes.stream;

  void onChangeNote(String note) {
    _statesNote.sink.add(note);
  }

  void onChangeAmount(String amount) {
    _statesAmount.sink.add(double.parse(amount));
  }

  void onChangeTypeId(String typeId) {
    _statesTypeId.sink.add(typeId);
  }

  Future<void> fetchInitialData({Function(String message) onError}) async {
    try {
      if (_statesEtcTypes.stream.value == null) {
        final List<TransactionEtcType> _types =
            await transactionService.getTransactionEtcTypes();

        _etcTypes = _types;
        _statesEtcTypes.sink.add(_etcTypes);
        _statesTypeId.sink.add(_etcTypes[0].id);
      }
    } catch (e) {
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> createTransactionEtc(
      {Function(String message) onError, Function onSuccess}) async {
    try {
      if (_validate()) {
        _statesLoading.sink.add(true);
        await transactionService.createTransactionEtc(TransactionEtc(
          amount: _statesAmount.stream.value,
          note: _statesNote.stream.value,
          type: _statesTypeId.stream.value,
        ));
        _statesLoading.sink.add(false);
        onSuccess();
      }
    } catch (e) {
      _statesLoading.sink.add(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  bool _validate() {
    bool validate = true;
    if (_statesAmount.stream.value == null || _statesAmount.stream.value == 0) {
      validate = false;
      _statesAmount.sink.addError('Biaya harus lebih dari 0');
    }

    return validate;
  }

  @override
  void dispose() {
    _statesNote?.close();
    _statesLoading?.close();
    _statesAmount?.close();
    _statesTypeId?.close();
    _statesEtcTypes?.close();
  }
}
