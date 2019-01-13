import 'package:flutter/material.dart';
import 'package:Recet/domains/item/model/dto/item.dart';
import 'package:Recet/domains/report/model/dto/transaction-detail.dart';
import 'package:Recet/presentations/screens/transaction-out/blocs/transaction-out-form-bloc.dart';
import 'package:Recet/presentations/screens/transaction-out/widgets/item-transaction-out-details-form.dart';
import 'package:Recet/presentations/screens/transaction-out/widgets/transaction-out-form-provider.dart';
import 'package:Recet/presentations/shared/widgets/button-add-row.dart';
import 'package:Recet/presentations/shared/widgets/button-loading.dart';
import 'package:Recet/presentations/shared/widgets/dropdown-custom.dart';
import 'package:Recet/values/colors.dart';

class TransactionOutDetailsForm extends StatelessWidget {
  final TextEditingController qtyController;
  final TextEditingController amountController;

  TransactionOutDetailsForm({
    @required this.qtyController,
    @required this.amountController,
  });

  @override
  Widget build(BuildContext context) {
    TransactionOutFormBloc _transactionOutFormBloc =
        TransactionOutFormProvider.of(context).transactionOutFormBloc;

    void showForm({int prevIndex}) {
      _transactionOutFormBloc.editTransactionDetail(
        prevIndex,
        onSuccess: (TransactionItemDetail trx) {
          qtyController.text = trx.qty.toString();
          amountController.text = trx.amount.toString();
        },
      );

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
                  stream: _transactionOutFormBloc.items,
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<Item>> itemSnapshot) {
                    return StreamBuilder<String>(
                      stream: _transactionOutFormBloc.tempFormDetailItemId,
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
                              _transactionOutFormBloc
                                  .onChangeTempDetailItemIdForm(_newItemId);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                    stream: _transactionOutFormBloc.loading,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<bool> loadingSnapshot) {
                      return StreamBuilder<int>(
                        stream: _transactionOutFormBloc.tempFormDetailQty,
                        builder:
                            (BuildContext ctx, AsyncSnapshot<int> qtySnapshot) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: TextField(
                              controller: qtyController,
                              maxLines: null,
                              onChanged: (String qty) {
                                _transactionOutFormBloc
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
                  stream: _transactionOutFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return StreamBuilder<double>(
                      stream: _transactionOutFormBloc.tempFormDetailAmount,
                      builder: (BuildContext ctx,
                          AsyncSnapshot<double> amountSnapshot) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: TextField(
                            controller: amountController,
                            maxLines: null,
                            onChanged: (String amount) {
                              _transactionOutFormBloc
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
                              errorText: amountSnapshot.error,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<bool>(
                  stream: _transactionOutFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return StreamBuilder<int>(
                      stream: _transactionOutFormBloc.tempFormDetailQty,
                      builder:
                          (BuildContext ctx, AsyncSnapshot<int> qtySnapshot) {
                        return StreamBuilder<double>(
                          stream: _transactionOutFormBloc.tempFormDetailAmount,
                          builder: (BuildContext ctx,
                              AsyncSnapshot<double> amountSnapshot) {
                            return Container(
                              width: double.infinity,
                              child: ButtonLoading(
                                color: PRIMARY_COLOR,
                                disabled: qtySnapshot.hasError ||
                                    amountSnapshot.hasError ||
                                    !qtySnapshot.hasData ||
                                    !amountSnapshot.hasData,
                                onPressed: () {
                                  _transactionOutFormBloc
                                      .addOrEditTransactionDetail(prevIndex,
                                          onSuccess: () {
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

    void deleteItemDetail(BuildContext ctx, int index) {
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
                    _transactionOutFormBloc.removeTransactionDetail(index);
                  },
                ),
              ],
            ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StreamBuilder<List<TransactionItemDetail>>(
                stream: _transactionOutFormBloc.details,
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<TransactionItemDetail>>
                        detailsSnapshot) {
                  return Text(
                    detailsSnapshot.error ?? '',
                    style: TextStyle(color: RED_COLOR),
                  );
                },
              ),
              ButtonAddRow(
                onPress: () {
                  showForm();
                },
              ),
            ],
          ),
          StreamBuilder<List<TransactionItemDetail>>(
            stream: _transactionOutFormBloc.details,
            builder: (BuildContext ctx,
                AsyncSnapshot<List<TransactionItemDetail>> detailsSnapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    detailsSnapshot.hasData ? detailsSnapshot.data.length : 0,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, int index) {
                  return ItemTransactionOutDetailsForm(
                    qty: detailsSnapshot.data[index].qty,
                    itemName: detailsSnapshot.data[index].itemName,
                    amount: detailsSnapshot.data[index].amount,
                    onEdit: () {
                      showForm(prevIndex: index);
                    },
                    onDelete: () {
                      deleteItemDetail(ctx, index);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
