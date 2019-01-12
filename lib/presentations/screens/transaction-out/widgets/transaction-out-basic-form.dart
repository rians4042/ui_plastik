import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/seller.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/blocs/transaction-out-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/widgets/transaction-out-form-provider.dart';
import 'package:plastik_ui/presentations/shared/widgets/dropdown-custom.dart';
import 'package:plastik_ui/values/colors.dart';

class TransactionOutBasicForm extends StatelessWidget {
  final TextEditingController noteController;
  TransactionOutBasicForm({@required this.noteController});

  @override
  Widget build(BuildContext context) {
    TransactionOutFormBloc _transactionOutFormBloc =
        TransactionOutFormProvider.of(context).transactionOutFormBloc;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<List<Seller>>(
                stream: _transactionOutFormBloc.sellers,
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<Seller>> sellersSnapshot) {
                  return StreamBuilder<String>(
                    stream: _transactionOutFormBloc.supplierId,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<String> sellerSelectedSnapshot) {
                      return DropdownCustom<String>(
                        label: 'Pilih Pembeli',
                        initialData: '',
                        loading: !sellerSelectedSnapshot.hasData,
                        value: sellerSelectedSnapshot?.data,
                        items: sellersSnapshot?.data
                            ?.map((supl) => DropdownMenuItem(
                                  child: Text(supl.name),
                                  value: supl.id,
                                  key: Key(supl.id),
                                ))
                            ?.toList(),
                        onChanged: (String supplierId) {
                          _transactionOutFormBloc.onChangeSupplier
                              .add(supplierId);
                        },
                        isExpanded: true,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: StreamBuilder<bool>(
                stream: _transactionOutFormBloc.loading,
                builder:
                    (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                  return StreamBuilder<String>(
                    stream: _transactionOutFormBloc.note,
                    builder:
                        (BuildContext ctx, AsyncSnapshot<String> snapshotNote) {
                      return TextField(
                        maxLines: null,
                        controller: noteController,
                        onChanged: (String address) =>
                            _transactionOutFormBloc.onChangeNote.add(address),
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
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
