import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';
import 'package:plastik_ui/values/colors.dart';

class ButtonTransactionInForm extends StatelessWidget {
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
            return Container(
              width: double.infinity,
              child: RaisedButton(
                color: PRIMARY_COLOR,
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (loadingSnapshot.hasData && loadingSnapshot.data) ||
                        detailsSnapshot.hasError
                    ? null
                    : submitForm(ctx),
              ),
            );
          },
        );
      },
    );
  }
}
