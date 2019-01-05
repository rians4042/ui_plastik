import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/actor/model/dto/supplier.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/domains/transaction/model/dto/transacation-detail.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-basic-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-details-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-in/widgets/transaction-in-form-provider.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-add-row.dart';
import 'package:plastik_ui/values/colors.dart';

class TransactionInForm extends StatefulWidget {
  static String routeName = '/transacationin';

  @override
  _TransactionInFormState createState() => _TransactionInFormState();
}

class _TransactionInFormState extends State<TransactionInForm> {
  TransactionInFormBloc _transactionInFormBloc;

  _TransactionInFormState() {
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
              _transactionInFormBloc.initialFetch(onError: (String message) {
                Scaffold.of(ctx).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              });
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
                        TransactionInBasicForm(),
                        TransactionInDetailsForm(),
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
