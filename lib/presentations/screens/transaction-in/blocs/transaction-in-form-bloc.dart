import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-in.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class TransactionInFormBloc implements BaseBloc {
  List<String> _images;
  List<TransactionItemDetail> _details;

  final TransactionService transactionService;
  final ActorService actorService;
  final ItemService itemService;

  BehaviorSubject<bool> _statesLoading;
  BehaviorSubject<String> _statesNote;
  BehaviorSubject<String> _statesSupplierId;
  BehaviorSubject<List<TransactionItemDetail>> _statesDetails;
  BehaviorSubject<List<String>> _statesImages;
  BehaviorSubject<List<Supplier>> _statesSuppliers;
  BehaviorSubject<List<Item>> _statesItems;

  // specially for temp detail
  BehaviorSubject<String> _statesTempFormDetailItemId;
  BehaviorSubject<int> _statesTempFormDetailQty;
  BehaviorSubject<double> _statesTempFormDetailAmount;

  Stream<bool> get loading => _statesLoading.stream;
  Stream<String> get note => _statesNote.stream;
  Stream<String> get supplierId => _statesSupplierId.stream;
  Stream<List<TransactionItemDetail>> get details => _statesDetails.stream;
  Stream<List<String>> get images => _statesImages.stream;
  Stream<List<Supplier>> get suppliers => _statesSuppliers.stream;
  Stream<List<Item>> get items => _statesItems.stream;

  // specially for temp detail
  Stream<String> get tempFormDetailItemId => _statesTempFormDetailItemId.stream;
  Stream<int> get tempFormDetailQty => _statesTempFormDetailQty.stream;
  Stream<double> get tempFormDetailAmount => _statesTempFormDetailAmount.stream;

  Sink<String> get onChangeNote => _statesNote.sink;
  Sink<String> get onChangeSupplier => _statesSupplierId.sink;
  Sink<String> get onChangeTempFormDetailItemId =>
      _statesTempFormDetailItemId.sink;
  Sink<int> get onChangeTempFormDetailQty => _statesTempFormDetailQty.sink;
  Sink<double> get onChangeTempFormDetailAmount =>
      _statesTempFormDetailAmount.sink;

  TransactionInFormBloc({
    @required this.transactionService,
    @required this.actorService,
    @required this.itemService,
  }) {
    _details = [];
    _images = [];

    _statesLoading = BehaviorSubject<bool>(seedValue: false);
    _statesNote = BehaviorSubject<String>();
    _statesSuppliers = BehaviorSubject<List<Supplier>>();
    _statesSupplierId = BehaviorSubject<String>();
    _statesDetails = BehaviorSubject<List<TransactionItemDetail>>();
    _statesImages = BehaviorSubject<List<String>>(seedValue: []);
    _statesItems = BehaviorSubject<List<Item>>();
    _statesTempFormDetailItemId = BehaviorSubject<String>();
    _statesTempFormDetailQty = BehaviorSubject<int>();
    _statesTempFormDetailAmount = BehaviorSubject<double>();
  }

  void addOrEditTransactionDetail(int index, {Function onSuccess}) {
    if (_validateTempDetailForm()) {
      final String itemId = _statesTempFormDetailItemId.stream.value;
      final int qty = _statesTempFormDetailQty.stream.value;
      final double amount = _statesTempFormDetailAmount.stream.value;
      final String itemName = _statesItems.stream.value
          .firstWhere((item) => item.id == itemId)
          .name;

      if (index != null) {
        int i = -1;
        _statesDetails.sink.add(_details.map((TransactionItemDetail detail) {
          i++;
          if (i == index) {
            return TransactionItemDetail(
              itemId: itemId,
              amount: amount,
              itemName: itemName,
              qty: qty,
            );
          }

          return detail;
        }).toList());
      } else {
        _statesDetails.sink.add(
          _details
            ..add(
              TransactionItemDetail(
                itemId: itemId,
                amount: amount,
                itemName: itemName,
                qty: qty,
              ),
            ),
        );
      }

      onSuccess();
    }
  }

  void onChangeTempDetailItemIdForm(String itemId) {
    onChangeTempFormDetailItemId.add(itemId);
  }

  void onChangeTempDetailQtyForm(String qty) {
    onChangeTempFormDetailQty.add(int.parse(qty));
  }

  void onChangeTempDetailAmountForm(String amount) {
    onChangeTempFormDetailAmount.add(double.parse(amount));
  }

  bool _validateTempDetailForm() {
    bool _validate = true;
    if (_statesTempFormDetailQty.stream.value == 0) {
      _validate = false;
      _statesTempFormDetailQty.sink.addError('Jumlah harus lebih besar dari 0');
    }

    if (_statesTempFormDetailAmount.stream.value == 0) {
      _validate = false;
      _statesTempFormDetailAmount.sink
          .addError('Biaya harus lebih besar dari 0');
    }

    return _validate;
  }

  void editTransactionDetail(int index,
      {Function(TransactionItemDetail) onSuccess}) {
    if (index == null) {
      String itemId = _statesItems.stream.value[0].id;
      _statesTempFormDetailQty.sink.add(null);
      _statesTempFormDetailAmount.sink.add(null);
      _statesTempFormDetailItemId.sink.add(itemId);
    } else {
      final TransactionItemDetail transactionItemDetail =
          _statesDetails.stream.value[index];

      _statesTempFormDetailQty.sink.add(transactionItemDetail.qty);
      _statesTempFormDetailAmount.sink.add(transactionItemDetail.amount);
      _statesTempFormDetailItemId.sink.add(transactionItemDetail.itemId);

      onSuccess(transactionItemDetail);
    }
  }

  void removeTransactionDetail(int index) {
    _statesDetails.sink.add(_details..removeAt(index));
  }

  void onAddImage(String image) {
    _statesImages.sink.add(_images..add(image));
  }

  void onRemoveImage(int index) {
    _statesImages.sink.add(_images..removeAt(index));
  }

  Future<void> initialFetch({Function(String message) onError}) async {
    try {
      if (_statesSuppliers.stream.value == null) {
        final _results = await Future.wait(
            [actorService.getSuppliers(), itemService.getItems()]);

        _statesItems.sink.add(_results[1]);
        _statesSuppliers.sink.add(_results[0]);
        _statesSupplierId.sink.add((_results[0][0] as Supplier).id);
      }
    } catch (e) {
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> createTransactionIn({
    Function(String message) onError,
    Function onSuccess,
  }) async {
    try {
      if (_validate()) {
        _statesLoading.sink.add(true);
        await transactionService.createTransactionIn(
          TransactionIn(
            note: _statesNote.stream.value,
            supplierId: _statesSupplierId.stream.value,
            details: _statesDetails.stream.value,
            images: _statesImages.stream.value,
          ),
        );
        _statesLoading.sink.add(false);
        _statesNote.sink.add('');
        _statesImages.sink.add(_images..clear());
        _statesDetails.sink.add(_details..clear());
        _statesSupplierId.sink.add(_statesSuppliers.stream.value[0].id);

        onSuccess();
      }
    } catch (e) {
      _statesLoading.sink.add(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  bool _validate() {
    bool validate = true;
    if (_statesSupplierId.stream.value == null) {
      validate = false;
      _statesSupplierId.sink.addError('Penyuplai tidak boleh kosong');
    }

    bool streamExistsAndLengthMoreThanZero =
        _statesDetails.stream.value != null &&
            _statesDetails.stream.value.length > 0;
    if (_statesDetails.stream.value == null ||
        !streamExistsAndLengthMoreThanZero) {
      validate = false;
      _statesDetails.sink.addError('Detail wajib diisi, minimal 1');
    }

    return validate;
  }

  @override
  void dispose() {
    _statesLoading?.close();
    _statesNote?.close();
    _statesSupplierId?.close();
    _statesSuppliers?.close();
    _statesDetails?.close();
    _statesImages?.close();
    _statesItems?.close();
    _statesTempFormDetailAmount?.close();
    _statesTempFormDetailQty?.close();
    _statesTempFormDetailItemId?.close();
  }
}
