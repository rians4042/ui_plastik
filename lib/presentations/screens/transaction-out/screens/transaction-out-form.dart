import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/blocs/transaction-out-form-bloc.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/widgets/button-transaction-out-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/widgets/transaction-out-basic-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/widgets/transaction-out-details-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/widgets/transaction-out-form-provider.dart';

class TransactionOutForm extends StatefulWidget {
  static String routeName = '/transacationout';

  @override
  _TransactionOutFormState createState() => _TransactionOutFormState();
}

class _TransactionOutFormState extends State<TransactionOutForm> {
  TextEditingController _noteController;
  TextEditingController _qtyController;
  TextEditingController _amountController;
  TransactionOutFormBloc _transactionOutFormBloc;

  _TransactionOutFormState() {
    _noteController = TextEditingController();
    _qtyController = TextEditingController();
    _amountController = TextEditingController();

    _transactionOutFormBloc = TransactionOutFormBloc(
      actorService: getIt<ActorService>(),
      transactionService: getIt<TransactionService>(),
      itemService: getIt<ItemService>(),
    );
  }

  @override
  void dispose() {
    _transactionOutFormBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionOutFormProvider(
      transactionOutFormBloc: _transactionOutFormBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Form Transaksi Keluar'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext ctx) {
            void fetchInitialData() {
              _transactionOutFormBloc.initialFetch(
                onError: (String message) {
                  Scaffold.of(ctx).showSnackBar(SnackBar(
                    content: Text(message),
                  ));
                },
              );
            }

            fetchInitialData();
            return SingleChildScrollView(
              primary: true,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: StreamBuilder<bool>(
                  stream: _transactionOutFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return Column(
                      children: <Widget>[
                        TransactionOutBasicForm(
                          noteController: _noteController,
                        ),
                        TransactionOutDetailsForm(
                          qtyController: _qtyController,
                          amountController: _amountController,
                        ),
                        ButtonTransactionOutForm(
                            noteController: _noteController),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
