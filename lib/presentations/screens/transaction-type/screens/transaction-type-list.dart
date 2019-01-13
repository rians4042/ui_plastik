import 'package:flutter/material.dart';
import 'package:Recet/domains/transaction/service/transaction.dart';
import 'package:Recet/presentations/screens/transaction-type/blocs/transaction-type-list.dart';
import 'package:Recet/presentations/screens/transaction-type/screens/transaction-type-form.dart';
import 'package:Recet/presentations/screens/transaction-type/states/transaction-type-list.dart';
import 'package:Recet/presentations/shared/widgets/error-notification.dart';
import 'package:Recet/presentations/shared/widgets/item-right-arrow.dart';
import 'package:Recet/presentations/shared/widgets/loading-indicator.dart';
import 'package:Recet/presentations/shared/widgets/not-found.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/values/type_list.dart';
import 'package:Recet/values/colors.dart';
import 'package:Recet/app.dart';

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
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: FluttonShimmering.list(
                    count: 10,
                    countLine: 5,
                    widthLine: MediaQuery.of(context).size.width * 0.95,
                    lastWidthLine: 28,
                    heightLine: 6,
                    typeList: FluttonShimmeringTypeList.ITEM,
                  ),
                );
                ;
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
