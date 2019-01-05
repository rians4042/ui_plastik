import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/presentations/screens/seller/blocs/seller-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:plastik_ui/app.dart';

class SellerForm extends StatefulWidget {
  final String id;

  SellerForm({this.id});

  static String routeName = '/seller/form';

  @override
  _SellerFormState createState() => _SellerFormState(id: id);
}

class _SellerFormState extends State<StatefulWidget> {
  final String id;

  SellerFormBloc _sellerFormBloc;
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;

  _SellerFormState({this.id}) {
    _sellerFormBloc = SellerFormBloc(actorService: getIt<ActorService>());
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _sellerFormBloc.dispose();
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
        title: Text('Formulir Penjual'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchSellerDetail() {
            _sellerFormBloc.getSellerDetail(id, onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }, onSuccess: (Seller seller) {
              _nameController.text = seller.name;
              _phoneController.text = seller.phone;
              _addressController.text = seller.address;
            });
          }

          void addOrUpdateSeller() {
            _sellerFormBloc.addOrUpdateSeller(
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

          void deleteSeller() {
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
                          _sellerFormBloc.deleteSeller(
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

          fetchSellerDetail();
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: StreamBuilder<bool>(
                stream: _sellerFormBloc.loading,
                builder:
                    (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                  return Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: _sellerFormBloc.name,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> nameSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              autofocus: true,
                              controller: _nameController,
                              onChanged: (String name) =>
                                  _sellerFormBloc.changeName.add(name),
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
                        stream: _sellerFormBloc.phone,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> phoneSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _phoneController,
                              onChanged: (String phone) =>
                                  _sellerFormBloc.changePhone.add(phone),
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
                        stream: _sellerFormBloc.address,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> addressSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _addressController,
                              onChanged: (String address) =>
                                  _sellerFormBloc.changeAddress.add(address),
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
                        stream: _sellerFormBloc.loading,
                        builder: (BuildContext ctx,
                                AsyncSnapshot<bool> loadSnapshot) =>
                            StreamBuilder<String>(
                              stream: _sellerFormBloc.name,
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<String> nameSnapshot) {
                                return StreamBuilder<String>(
                                  stream: _sellerFormBloc.phone,
                                  builder: (BuildContext ctx,
                                      AsyncSnapshot<String> phoneSnapshot) {
                                    return Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: ButtonLoading(
                                        color: PRIMARY_COLOR,
                                        loading: loadSnapshot.hasData &&
                                            loadSnapshot.data,
                                        disabled: !nameSnapshot.hasData ||
                                            !phoneSnapshot.hasData ||
                                            nameSnapshot.hasError ||
                                            phoneSnapshot.hasError,
                                        onPressed: addOrUpdateSeller,
                                        child: Text(
                                          'Simpan',
                                          style: TextStyle(color: WHITE_COLOR),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                      ),
                      id != null
                          ? StreamBuilder<bool>(
                              stream: _sellerFormBloc.loading,
                              builder: (BuildContext ctx,
                                      AsyncSnapshot<bool> loadSnapshot) =>
                                  StreamBuilder<String>(
                                    stream: _sellerFormBloc.name,
                                    builder: (BuildContext ctx,
                                        AsyncSnapshot<String> nameSnapshot) {
                                      return StreamBuilder<String>(
                                        stream: _sellerFormBloc.phone,
                                        builder: (BuildContext ctx,
                                            AsyncSnapshot<String>
                                                phoneSnapshot) {
                                          return Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: ButtonLoading(
                                              color: RED_COLOR,
                                              loading: loadSnapshot.hasData &&
                                                  loadSnapshot.data,
                                              disabled: !nameSnapshot.hasData ||
                                                  !phoneSnapshot.hasData ||
                                                  nameSnapshot.hasError ||
                                                  phoneSnapshot.hasError,
                                              onPressed: deleteSeller,
                                              child: Text(
                                                'Hapus',
                                                style: TextStyle(
                                                    color: WHITE_COLOR),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
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
