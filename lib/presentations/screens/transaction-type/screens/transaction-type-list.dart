import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/transaction/service/transaction.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/blocs/transaction-type-list.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/screens/transaction-type-form.dart';
import 'package:plastik_ui/presentations/screens/transaction-type/states/transaction-type-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:plastik_ui/app.dart';

class TransactionTypeList extends StatefulWidget {
  static String routeName = '/transactiontype';

  @override
  State<StatefulWidget> createState() => _TransactionTypeListState();
}

class _TransactionTypeListState extends State<TransactionTypeList> {
  TransactionTypeListBloc _transactionTypeListBloc;

  _TransactionTypeListState() {
    _transactionTypeListBloc = TransactionTypeListBloc(
        transactionService: getIt<TransactionService>());
  }

  @override
  void dispose() {
    _transactionTypeListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipe Transaksi Lainnya'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchTransactionTypes() {
            _transactionTypeListBloc.fetchTransactionTypes(
                onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            });
          }

          fetchTransactionTypes();
          return StreamBuilder<TransactionTypeListState>(
            stream: _transactionTypeListBloc.transactionTypeList,
            builder: (BuildContext ctx,
                AsyncSnapshot<TransactionTypeListState> snapshot) {
              // show loading when the loading state is true and error is false
              if (snapshot.hasData &&
                  snapshot.data.loading &&
                  !snapshot.hasError) {
                return LoadingIndicator();
              }

              // show page empty data whenever data is zero and no error on there
              if (snapshot.hasData &&
                  snapshot.data.count == 0 &&
                  !snapshot.hasError) {
                return NotFound();
              }

              if (snapshot.hasError) {
                return ErrorNotification(
                  onRetry: fetchTransactionTypes,
                );
              }

              return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data.count : 0,
                itemBuilder: (BuildContext ctx, int index) {
                  return ItemRightArrow(
                    label: snapshot.data.types[index].name,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TransactionTypeForm(
                                id: snapshot.data.types[index].id,
                              ),
                          settings: RouteSettings(
                            name: TransactionTypeForm.routeName,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TransactionTypeForm(),
              settings: RouteSettings(
                name: TransactionTypeForm.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
