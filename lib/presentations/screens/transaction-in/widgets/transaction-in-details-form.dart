import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-add-row.dart';
import 'package:plastik_ui/presentations/shared/widgets/dropdown-custom.dart';
import 'package:plastik_ui/values/colors.dart';

class TransactionInDetailsForm extends StatelessWidget {
  TextEditingController _qtyController;
  TextEditingController _amountController;

  TransactionInDetailsForm() {
    _qtyController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    TransactionInFormBloc _transactionInFormBloc =
        TransactionInFormProvider.of(context).transactionInFormBloc;

    void showForm({int prevIndex}) {
      _transactionInFormBloc.editTransactionDetail(prevIndex,
          onSuccess: (TransactionItemDetail trx) {
        _qtyController.text = trx.qty.toString();
        _amountController.text = trx.amount.toString();
      });

      showBottomSheet<void>(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<List<Item>>(
                  stream: _transactionInFormBloc.items,
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<Item>> itemSnapshot) {
                    return StreamBuilder<String>(
                      stream: _transactionInFormBloc.tempFormDetailItemId,
                      builder: (BuildContext ctx,
                          AsyncSnapshot<String> itemSelectedSnapshot) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: DropdownCustom<String>(
                            label: 'Pilih Barang',
                            loading: !itemSnapshot.hasData,
                            initialData: '',
                            isExpanded: true,
                            items: itemSnapshot?.data
                                ?.map(
                                  (item) => DropdownMenuItem(
                                        key: Key(item.id),
                                        child: Text(item.name),
                                        value: item.id,
                                      ),
                                )
                                ?.toList(),
                            value: itemSelectedSnapshot.data,
                            onChanged: (String _newItemId) {
                              _transactionInFormBloc
                                  .onChangeTempDetailItemIdForm(_newItemId);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                    stream: _transactionInFormBloc.loading,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<bool> loadingSnapshot) {
                      return StreamBuilder<int>(
                        stream: _transactionInFormBloc.tempFormDetailQty,
                        builder:
                            (BuildContext ctx, AsyncSnapshot<int> qtySnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: _qtyController,
                              maxLines: null,
                              onChanged: (String qty) {
                                _transactionInFormBloc
                                    .onChangeTempDetailQtyForm(qty);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: GREY_COLOR,
                                  ),
                                ),
                                labelText: 'Jumlah',
                                enabled: loadingSnapshot.hasData
                                    ? !loadingSnapshot.data
                                    : true,
                                errorText: qtySnapshot.error,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                StreamBuilder<bool>(
                  stream: _transactionInFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return StreamBuilder<double>(
                      stream: _transactionInFormBloc.tempFormDetailAmount,
                      builder: (BuildContext ctx,
                          AsyncSnapshot<double> amountSnapshot) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: TextField(
                            controller: _amountController,
                            maxLines: null,
                            onChanged: (String amount) {
                              _transactionInFormBloc
                                  .onChangeTempDetailAmountForm(amount);
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
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: _transactionInFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return StreamBuilder<int>(
                      stream: _transactionInFormBloc.tempFormDetailQty,
                      builder:
                          (BuildContext ctx, AsyncSnapshot<int> qtySnapshot) {
                        return StreamBuilder<double>(
                          stream: _transactionInFormBloc.tempFormDetailAmount,
                          builder: (BuildContext ctx,
                              AsyncSnapshot<double> amountSnapshot) {
                            return Container(
                              width: double.infinity,
                              child: RaisedButton(
                                color: PRIMARY_COLOR,
                                onPressed: (loadingSnapshot.hasData &&
                                            loadingSnapshot.data) ||
                                        qtySnapshot.hasError ||
                                        amountSnapshot.hasError
                                    ? null
                                    : () {
                                        _transactionInFormBloc
                                            .addOrEditTransactionDetail(
                                                prevIndex, onSuccess: () {
                                          Navigator.of(ctx).pop();
                                        });
                                      },
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(color: WHITE_COLOR),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ButtonAddRow(
            onPress: () {
              showForm();
            },
          ),
          StreamBuilder<List<TransactionItemDetail>>(
            stream: _transactionInFormBloc.details,
            builder: (BuildContext ctx,
                AsyncSnapshot<List<TransactionItemDetail>> detailsSnapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    detailsSnapshot.hasData ? detailsSnapshot.data.length : 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, int index) {
                  return Text('helo');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
