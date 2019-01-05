import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transaction-etc-type.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/presentations/screens/transaction-etc/blocs/transaction-etc-form.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/presentations/shared/widgets/dropdown-custom.dart';
import 'package:plastik_ui/values/colors.dart';

class TransactionEtcForm extends StatefulWidget {
  static String routeName = '/transactionetc';

  @override
  _TransactionEtcFormState createState() => _TransactionEtcFormState();
}

class _TransactionEtcFormState extends State<TransactionEtcForm> {
  _TransactionEtcFormState() {
    _amountController = TextEditingController();
    _noteController = TextEditingController();

    _transactionEtcFormBloc =
        TransactionEtcFormBloc(transactionService: getIt<TransactionService>());
  }

  TextEditingController _amountController;
  TextEditingController _noteController;
  TransactionEtcFormBloc _transactionEtcFormBloc;

  @override
  void dispose() {
    _transactionEtcFormBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Pengeluaran Lainnya'),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext ctx) {
            void fetchInitialData() {
              _transactionEtcFormBloc.fetchInitialData(
                  onError: (String message) {
                Scaffold.of(ctx).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              });
            }

            void submitTransaction() {
              showDialog(
                context: ctx,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Konfirmasi'),
                      content:
                          Text('Apakah transaksi yang dimasukkan sesuai ?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Tidak'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        FlatButton(
                          child: Text('Ya'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            _transactionEtcFormBloc.createTransactionEtc(
                                onError: (String message) {
                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            }, onSuccess: () {
                              _noteController.text = '';
                              _amountController.text = '';

                              Scaffold.of(ctx).showSnackBar(SnackBar(
                                content: Text(
                                    'Berhasil menambahkan transaksi lainnya'),
                              ));
                            });
                          },
                        ),
                      ],
                    ),
              );
            }

            fetchInitialData();
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<TransactionEtcType>>(
                    stream: _transactionEtcFormBloc.types,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<List<TransactionEtcType>> typesSnapshot) {
                      return StreamBuilder<String>(
                        stream: _transactionEtcFormBloc.type,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> typeSelectedSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: DropdownCustom<String>(
                              initialData: '',
                              items: typesSnapshot?.data
                                  ?.map((type) => DropdownMenuItem(
                                        child: Text(type.name),
                                        value: type.id,
                                      ))
                                  ?.toList(),
                              label: 'Pilih Kategori Pengeluaran',
                              loading: !typesSnapshot.hasData,
                              value: typeSelectedSnapshot.data,
                              isExpanded: true,
                              onChanged: (String id) {
                                _transactionEtcFormBloc.onChangeTypeId(id);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: _transactionEtcFormBloc.loading,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<bool> loadingSnapshot) {
                      return StreamBuilder<double>(
                        stream: _transactionEtcFormBloc.amount,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<double> amountSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _amountController,
                              maxLines: null,
                              onChanged: (String amount) {
                                _transactionEtcFormBloc.onChangeAmount(amount);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                labelText: 'Biaya',
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                                errorText: amountSnapshot.error,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: _transactionEtcFormBloc.loading,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<bool> loadingSnapshot) {
                      return StreamBuilder<String>(
                        stream: _transactionEtcFormBloc.note,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<String> noteSnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _noteController,
                              maxLines: null,
                              onChanged: (String address) =>
                                  _transactionEtcFormBloc.onChangeNote(address),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                labelText: 'Catatan',
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<double>(
                    stream: _transactionEtcFormBloc.amount,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<double> amountSnapshot) {
                      return StreamBuilder<bool>(
                        stream: _transactionEtcFormBloc.loading,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<bool> loadingSnapshot) {
                          return Container(
                            width: double.infinity,
                            child: ButtonLoading(
                              color: PRIMARY_COLOR,
                              loading: loadingSnapshot.hasData &&
                                  loadingSnapshot.data,
                              disabled: !amountSnapshot.hasData ||
                                  amountSnapshot.data == 0,
                              child: Text(
                                'Simpan',
                                style: TextStyle(color: WHITE_COLOR),
                              ),
                              onPressed: () {
                                submitTransaction();
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
