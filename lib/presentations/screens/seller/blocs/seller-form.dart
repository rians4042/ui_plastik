import 'dart:async';

import 'package:meta/meta.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:plastik_ui/validators/format-phone.dart';

class SellerFormBloc extends Object
    with FormatPhoneValidator, FormatPhoneValidatorStream
    implements BaseBloc {
  ActorService actorService;

  BehaviorSubject<String> _stateName;
  BehaviorSubject<String> _statePhone;
  BehaviorSubject<String> _stateAddress;
  BehaviorSubject<bool> _stateLoading;

  Sink<String> get changeName => _stateName.sink;
  Sink<String> get changePhone => _statePhone.sink;
  Sink<String> get changeAddress => _stateAddress.sink;

  Stream<String> get name => _stateName.stream;
  Stream<String> get phone =>
      _statePhone.stream.transform(validatePhoneNumberStream);
  Stream<String> get address => _stateAddress.stream;
  Stream<bool> get loading => _stateLoading.stream;

  SellerFormBloc({@required this.actorService}) {
    _stateName = BehaviorSubject<String>();
    _statePhone = BehaviorSubject<String>();
    _stateAddress = BehaviorSubject<String>();
    _stateLoading = BehaviorSubject<bool>(seedValue: false);
  }

  Future<void> getSellerDetail(String id,
      {Function(String message) onError,
      Function(Seller seller) onSuccess}) async {
    if (id != null && _isPreviousDataIsNull()) {
      try {
        Seller seller = await actorService.getSellerDetail(id);

        _stateName.sink.add(seller.name);
        _statePhone.sink.add(seller.phone);
        _stateAddress.sink.add(seller.address);

        onSuccess(seller);
      } catch (e) {
        _stateLoading.sink.add(false);
        onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
      }
    }
  }

  Future<void> addOrUpdateSeller(String id,
      {Function(String message) onError, Function() onSuccess}) async {
    try {
      if (_validate()) {
        _stateLoading.sink.add(true);
        if (id == null) {
          await actorService.createSeller(Seller(
            name: _stateName.stream.value,
            phone: _statePhone.stream.value,
            address: _stateAddress.stream.value,
          ));
        } else {
          await actorService.updateSeller(
              id,
              Seller(
                name: _stateName.stream.value,
                phone: _statePhone.stream.value,
                address: _stateAddress.stream.value,
              ));
        }
        _stateLoading.sink.add(false);
        onSuccess();
      }
    } catch (e) {
      _stateLoading.sink.add(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  Future<void> deleteSeller(String id,
      {Function(String message) onError, Function() onSuccess}) async {
    try {
      _stateLoading.sink.add(true);
      await actorService.deleteSeller(id);
      _stateLoading.sink.add(false);
      onSuccess();
    } catch (e) {
      _stateLoading.sink.add(false);
      onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
    }
  }

  bool _validate() {
    bool validate = true;
    if (_stateName.stream.value == '' || _stateName.stream.value == null) {
      validate = false;
      _stateName.sink.addError('Nama tidak boleh kosong');
    }

    String err = validatePhoneNumber(_statePhone.stream.value);
    if (_statePhone.stream.value == '' ||
        _statePhone.stream.value == null ||
        err != '') {
      validate = false;
      _statePhone.sink.addError(err);
    }

    return validate;
  }

  bool _isPreviousDataIsNull() {
    return _stateName.stream.value == null &&
        _stateAddress.stream.value == null &&
        _statePhone.stream.value == null;
  }

  @override
  void dispose() {
    _stateAddress?.close();
    _stateLoading?.close();
    _stateName?.close();
    _statePhone?.close();
  }
}
