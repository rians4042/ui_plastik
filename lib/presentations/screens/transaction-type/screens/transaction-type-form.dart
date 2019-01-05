import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/blocs/transaction-type-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:plastik_ui/app.dart';

class TransactionTypeForm extends StatefulWidget {
  final String id;

  TransactionTypeForm({this.id});

  static String routeName = '/transactiontype/form';

  @override
  _TransactionTypeFormState createState() => _TransactionTypeFormState(id: id);
}

class _TransactionTypeFormState extends State<StatefulWidget> {
  final String id;

  TransactionTypeFormBloc _transactionTypeFormBloc;
  TextEditingController _nameController;
  _TransactionTypeFormState({this.id}) {
    _transactionTypeFormBloc = TransactionTypeFormBloc(
        transactionService: getIt<TransactionService>());
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _transactionTypeFormBloc.dispose();
    _nameController.dispose();

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
          void fetchTransactionTypeDetail() {
            _transactionTypeFormBloc.fetchDetailTransactionType(id,
                onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }, onSuccess: (TransactionEtcType transactionEtcType) {
              _nameController.text = transactionEtcType.name;
            });
          }

          void addOrUpdateTransactionType() {
            _transactionTypeFormBloc.addOrUpdateTransactionType(
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

          void deleteTransactionType() {
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
                          _transactionTypeFormBloc.deleteTransactionType(
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

          fetchTransactionTypeDetail();
          return StreamBuilder<bool>(
            stream: _transactionTypeFormBloc.loading,
            builder: (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                        stream: _transactionTypeFormBloc.name,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> nameSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              autofocus: true,
                              controller: _nameController,
                              onChanged: (String name) =>
                                  _transactionTypeFormBloc.changeName.add(name),
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
                      StreamBuilder<bool>(
                        stream: _transactionTypeFormBloc.loading,
                        builder: (BuildContext ctx,
                                AsyncSnapshot<bool> loadSnapshot) =>
                            StreamBuilder<String>(
                              stream: _transactionTypeFormBloc.name,
                              builder: (BuildContext ctx,
                                      AsyncSnapshot<String> nameSnapshot) =>
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: ButtonLoading(
                                      color: PRIMARY_COLOR,
                                      loading: loadSnapshot.hasData &&
                                          loadSnapshot.data,
                                      disabled: nameSnapshot.hasError ||
                                          !nameSnapshot.hasData,
                                      onPressed: addOrUpdateTransactionType,
                                      child: Text(
                                        'Simpan',
                                        style: TextStyle(color: WHITE_COLOR),
                                      ),
                                    ),
                                  ),
                            ),
                      ),
                      id != null
                          ? StreamBuilder<bool>(
                              stream: _transactionTypeFormBloc.loading,
                              builder: (BuildContext ctx,
                                      AsyncSnapshot<bool> loadSnapshot) =>
                                  StreamBuilder<String>(
                                    stream: _transactionTypeFormBloc.name,
                                    builder: (BuildContext ctx,
                                            AsyncSnapshot<String>
                                                nameSnapshot) =>
                                        Container(
                                          width: double.infinity,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: ButtonLoading(
                                            color: RED_COLOR,
                                            loading: loadSnapshot.hasData &&
                                                loadSnapshot.data,
                                            disabled: nameSnapshot.hasError ||
                                                !nameSnapshot.hasData,
                                            onPressed: deleteTransactionType,
                                            child: Text(
                                              'Hapus',
                                              style:
                                                  TextStyle(color: WHITE_COLOR),
                                            ),
                                          ),
                                        ),
                                  ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
