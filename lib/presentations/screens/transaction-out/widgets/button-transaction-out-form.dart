import 'package:flutter/material.dart';
import 'package:Recet/domains/actor/model/dto/seller.dart';
import 'package:Recet/domains/item/model/dto/item.dart';
import 'package:Recet/domains/report/model/dto/transaction-detail.dart';
import 'package:Recet/presentations/screens/transaction-out/blocs/transaction-out-form-bloc.dart';
import 'package:Recet/presentations/screens/transaction-out/widgets/transaction-out-form-provider.dart';
import 'package:Recet/presentations/shared/widgets/button-loading.dart';
import 'package:Recet/values/colors.dart';

class ButtonTransactionOutForm extends StatelessWidget {
  final TextEditingController noteController;

  ButtonTransactionOutForm({@required this.noteController});

  @override
  Widget build(BuildContext context) {
    TransactionOutFormBloc _transactionOutFormBloc =
        TransactionOutFormProvider.of(context).transactionOutFormBloc;

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
                      _transactionOutFormBloc.createTransactionOut(
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
                                'Berhasil membuat transaksi keluar',
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
      stream: _transactionOutFormBloc.loading,
      builder: (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
        return StreamBuilder<List<TransactionItemDetail>>(
          stream: _transactionOutFormBloc.details,
          builder: (BuildContext ctx,
              AsyncSnapshot<List<TransactionItemDetail>> detailsSnapshot) {
            return StreamBuilder<List<Seller>>(
              stream: _transactionOutFormBloc.sellers,
              builder: (BuildContext ctx,
                  AsyncSnapshot<List<Seller>> sellersSnapshot) {
                return StreamBuilder<List<Item>>(
                  stream: _transactionOutFormBloc.items,
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
                            !sellersSnapshot.hasData ||
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
