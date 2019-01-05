import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';
import 'package:plastik_ui/presentations/shared/widgets/dropdown-custom.dart';
import 'package:plastik_ui/values/colors.dart';

class TransactionInBasicForm extends StatelessWidget {
  final TextEditingController noteController;
  TransactionInBasicForm({@required this.noteController});

  @override
  Widget build(BuildContext context) {
    TransactionInFormBloc _transactionInFormBloc =
        TransactionInFormProvider.of(context).transactionInFormBloc;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<List<Supplier>>(
                stream: _transactionInFormBloc.suppliers,
                builder: (BuildContext ctx,
                    AsyncSnapshot<List<Supplier>> suppliersSnapshot) {
                  return StreamBuilder<String>(
                    stream: _transactionInFormBloc.supplierId,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<String> supplierSelectedSnapshot) {
                      return DropdownCustom<String>(
                        label: 'Pilih Penyuplai',
                        initialData: '',
                        loading: !suppliersSnapshot.hasData,
                        value: supplierSelectedSnapshot?.data,
                        items: suppliersSnapshot?.data
                            ?.map((supl) => DropdownMenuItem(
                                  child: Text(supl.name),
                                  value: supl.id,
                                  key: Key(supl.id),
                                ))
                            ?.toList(),
                        onChanged: (String supplierId) {
                          _transactionInFormBloc.onChangeSupplier
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
                stream: _transactionInFormBloc.loading,
                builder:
                    (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                  return StreamBuilder<String>(
                    stream: _transactionInFormBloc.note,
                    builder:
                        (BuildContext ctx, AsyncSnapshot<String> snapshotNote) {
                      return TextField(
                        maxLines: null,
                        controller: noteController,
                        onChanged: (String address) =>
                            _transactionInFormBloc.onChangeNote.add(address),
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
