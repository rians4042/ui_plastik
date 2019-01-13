import 'package:flutter/material.dart';
import 'package:Recet/domains/actor/service/actor.dart';
import 'package:Recet/domains/item/service/item.dart';
import 'package:Recet/domains/transaction/service/transaction.dart';
import 'package:Recet/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:Recet/app.dart';
import 'package:Recet/presentations/screens/transaction-in/widgets/button-transaction-in-form.dart';
import 'package:Recet/presentations/screens/transaction-in/widgets/transaction-in-basic-form.dart';
import 'package:Recet/presentations/screens/transaction-in/widgets/transaction-in-details-form.dart';
import 'package:Recet/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';

class TransactionInForm extends StatefulWidget {
  static String routeName = '/transacationin';

  @override
  _TransactionInFormState createState() => _TransactionInFormState();
}

class _TransactionInFormState extends State<TransactionInForm> {
  TextEditingController _noteController;
  TextEditingController _qtyController;
  TextEditingController _amountController;
  TransactionInFormBloc _transactionInFormBloc;

  _TransactionInFormState() {
    _noteController = TextEditingController();
    _qtyController = TextEditingController();
    _amountController = TextEditingController();

    _transactionInFormBloc = TransactionInFormBloc(
      actorService: getIt<ActorService>(),
      transactionService: getIt<TransactionService>(),
      itemService: getIt<ItemService>(),
    );
  }

  @override
  void dispose() {
    _transactionInFormBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionInFormProvider(
      transactionInFormBloc: _transactionInFormBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Form Transaksi Masuk'),
          centerTitle: true,
        ),
        body: Builder(
          builder: (BuildContext ctx) {
            void fetchInitialData() {
              _transactionInFormBloc.initialFetch(
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
                  stream: _transactionInFormBloc.loading,
                  builder:
                      (BuildContext ctx, AsyncSnapshot<bool> loadingSnapshot) {
                    return Column(
                      children: <Widget>[
                        TransactionInBasicForm(
                          noteController: _noteController,
                        ),
                        TransactionInDetailsForm(
                          qtyController: _qtyController,
                          amountController: _amountController,
                        ),
                        ButtonTransactionInForm(
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
