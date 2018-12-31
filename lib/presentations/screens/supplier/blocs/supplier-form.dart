import 'dart:async';

import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/validators/format-phone.dart';

class SupplierFormBloc extends Object
    with FormatPhoneValidator, FormatPhoneValidatorStream
    implements BaseBloc {
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

  SupplierFormBloc() {
    _stateName = BehaviorSubject<String>();
    _statePhone = BehaviorSubject<String>();
    _stateAddress = BehaviorSubject<String>();
    _stateLoading = BehaviorSubject<bool>(seedValue: false);
  }

  Future<void> getSupplierDetail(String id,
      {Function(String message) onError,
      Function(Supplier supplier) onSuccess}) async {
    if (id != null && _isPreviousDataIsNull()) {
      try {
        _stateLoading.sink.add(true);
        Supplier supplier =
            await (getIt<ActorService>() as ActorService).getSupplierDetail(id);

        _stateName.sink.add(supplier.name);
        _statePhone.sink.add(supplier.phone);
        _stateAddress.sink.add(supplier.address);
        _stateLoading.sink.add(false);

        onSuccess(supplier);
      } catch (e) {
        _stateLoading.sink.add(false);
        onError(e?.message ?? 'Terjadi Kesalahan Pada Server');
      }
    }
  }

  Future<void> addOrUpdateSupplier(String id,
      {Function(String message) onError, Function() onSuccess}) async {
    try {
      if (_validate()) {
        _stateLoading.sink.add(true);
        if (id == null) {
          await (getIt<ActorService>() as ActorService).createSupplier(Supplier(
            name: _stateName.stream.value,
            phone: _statePhone.stream.value,
            address: _stateAddress.stream.value,
          ));
        } else {
          await (getIt<ActorService>() as ActorService).updateSupplier(
              id,
              Supplier(
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

  Future<void> deleteSupplier(String id,
      {Function(String message) onError, Function() onSuccess}) async {
    try {
      _stateLoading.sink.add(true);
      await (getIt<ActorService>() as ActorService).deleteSupplier(id);
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
