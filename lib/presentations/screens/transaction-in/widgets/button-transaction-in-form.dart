import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/report/model/dto/transaction-detail.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/values/colors.dart';

class ButtonTransactionInForm extends StatelessWidget {
  final TextEditingController noteController;

  ButtonTransactionInForm({@required this.noteController});

  @override
  Widget build(BuildContext context) {
    TransactionInFormBloc _transactionInFormBloc =
        TransactionInFormProvider.of(context).transactionInFormBloc;

    Function submitForm(BuildContext ctx) {
      return () {
        showDialog(
          context: ctx,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Konfirmasi'),
                content: Text('Apakah transaksi yang dimasukkan sesuai ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Tidak'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                  FlatButton(
                    child: Text('Ya'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _transactionInFormBloc.createTransactionIn(
                        onError: (String message) {
                          Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        },
                        onSuccess: () {
                          noteController.clear();
                          Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Berhasil membuat transaksi masuk',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
        );
      };
    }

    return StreamBuilder<bool>(
      stream: _transactionInFormBloc.loading,
      builder: (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
        return StreamBuilder<List<TransactionItemDetail>>(
          stream: _transactionInFormBloc.details,
          builder: (BuildContext ctx,
              AsyncSnapshot<List<TransactionItemDetail>> detailsSnapshot) {
            return StreamBuilder<List<Supplier>>(
              stream: _transactionInFormBloc.suppliers,
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<Supplier>> suppliersSnapshot) {
                return StreamBuilder<List<Item>>(
                  stream: _transactionInFormBloc.items,
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<Item>> itemsSnapshot) {
                    return Container(
                      width: double.infinity,
                      child: ButtonLoading(
                        color: PRIMARY_COLOR,
                        child: Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                        disabled: !detailsSnapshot.hasData ||
                            detailsSnapshot.hasError ||
                            !suppliersSnapshot.hasData ||
                            !itemsSnapshot.hasData,
                        loading:
                            (loadingSnapshot.hasData && loadingSnapshot.data),
                        onPressed: submitForm(ctx),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
