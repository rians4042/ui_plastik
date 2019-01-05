import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/screens/supplier/blocs/supplier-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:plastik_ui/app.dart';

class SupplierForm extends StatefulWidget {
  final String id;

  SupplierForm({this.id});

  static String routeName = '/supplier/form';

  @override
  _SupplierFormState createState() => _SupplierFormState(id: id);
}

class _SupplierFormState extends State<StatefulWidget> {
  final String id;

  SupplierFormBloc _supplierFormBloc;
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;

  _SupplierFormState({this.id}) {
    _supplierFormBloc = SupplierFormBloc(actorService: getIt<ActorService>());
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _supplierFormBloc.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Penyuplai'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchSupplierDetail() {
            _supplierFormBloc.getSupplierDetail(id, onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }, onSuccess: (Supplier supplier) {
              _nameController.text = supplier.name;
              _phoneController.text = supplier.phone;
              _addressController.text = supplier.address;
            });
          }

          void addOrUpdateSupplier() {
            _supplierFormBloc.addOrUpdateSupplier(
              id,
              onSuccess: () {
                Navigator.of(ctx).pop();
              },
              onError: (String message) {
                Scaffold.of(ctx).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              },
            );
          }

          void deleteSupplier() {
            showDialog(
              context: ctx,
              builder: (BuildContext context) => AlertDialog(
                    title: Text('Hapus'),
                    content: Text('Apakah anda yakin menghapus data ini ?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Tidak'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      FlatButton(
                        child: Text('Hapus'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _supplierFormBloc.deleteSupplier(
                            id,
                            onSuccess: () {
                              Navigator.of(ctx).pop();
                            },
                            onError: (String message) {
                              Scaffold.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
            );
          }

          fetchSupplierDetail();
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: StreamBuilder<bool>(
                stream: _supplierFormBloc.loading,
                builder:
                    (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                  return Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: _supplierFormBloc.name,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> nameSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              autofocus: true,
                              controller: _nameController,
                              onChanged: (String name) =>
                                  _supplierFormBloc.changeName.add(name),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                                errorText: nameSnapshot.error,
                                labelText: 'Nama',
                              ),
                            ),
                          );
                        },
                      ),
                      StreamBuilder<String>(
                        stream: _supplierFormBloc.phone,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> phoneSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _phoneController,
                              onChanged: (String phone) =>
                                  _supplierFormBloc.changePhone.add(phone),
                              keyboardType: TextInputType.phone,
                              maxLength: 16,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                                errorText: phoneSnapshot.error,
                                labelText: 'Nomor Telepon',
                              ),
                            ),
                          );
                        },
                      ),
                      StreamBuilder<String>(
                        stream: _supplierFormBloc.address,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> addressSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _addressController,
                              onChanged: (String address) =>
                                  _supplierFormBloc.changeAddress.add(address),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                                errorText: addressSnapshot.error,
                                labelText: 'Alamat',
                              ),
                            ),
                          );
                        },
                      ),
                      StreamBuilder<bool>(
                        stream: _supplierFormBloc.loading,
                        builder: (BuildContext ctx,
                                AsyncSnapshot<bool> loadSnapshot) =>
                            StreamBuilder<String>(
                              stream: _supplierFormBloc.name,
                              builder: (BuildContext ctx,
                                      AsyncSnapshot<String> nameSnapshot) =>
                                  StreamBuilder<String>(
                                    stream: _supplierFormBloc.phone,
                                    builder: (BuildContext ctx,
                                            AsyncSnapshot<String>
                                                phoneSnapshot) =>
                                        Container(
                                          width: double.infinity,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: ButtonLoading(
                                            color: PRIMARY_COLOR,
                                            loading: loadSnapshot.hasData &&
                                                loadSnapshot.data,
                                            disabled: !nameSnapshot.hasData ||
                                                !phoneSnapshot.hasData ||
                                                nameSnapshot.hasError ||
                                                phoneSnapshot.hasError,
                                            onPressed: addOrUpdateSupplier,
                                            child: Text(
                                              'Simpan',
                                              style:
                                                  TextStyle(color: WHITE_COLOR),
                                            ),
                                          ),
                                        ),
                                  ),
                            ),
                      ),
                      id != null
                          ? StreamBuilder<bool>(
                              stream: _supplierFormBloc.loading,
                              builder: (BuildContext ctx,
                                      AsyncSnapshot<bool> loadSnapshot) =>
                                  StreamBuilder<String>(
                                    stream: _supplierFormBloc.name,
                                    builder: (BuildContext ctx,
                                            AsyncSnapshot<String>
                                                nameSnapshot) =>
                                        StreamBuilder<String>(
                                          stream: _supplierFormBloc.phone,
                                          builder: (BuildContext ctx,
                                                  AsyncSnapshot<String>
                                                      phoneSnapshot) =>
                                              Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: ButtonLoading(
                                                  color: RED_COLOR,
                                                  loading:
                                                      loadSnapshot.hasData &&
                                                          loadSnapshot.data,
                                                  disabled: !nameSnapshot
                                                          .hasData ||
                                                      !phoneSnapshot.hasData ||
                                                      nameSnapshot.hasError ||
                                                      phoneSnapshot.hasError,
                                                  onPressed: deleteSupplier,
                                                  child: Text(
                                                    'Hapus',
                                                    style: TextStyle(
                                                        color: WHITE_COLOR),
                                                  ),
                                                ),
                                              ),
                                        ),
                                  ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
