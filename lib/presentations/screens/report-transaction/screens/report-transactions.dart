import 'package:flutter/material.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/blocs/report-transactions.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/screens/report-transaction-detail.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/states/report-transactions.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/widgets/input-picker-datetime.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/widgets/item-transaction.dart';
import 'package:plastik_ui/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:plastik_ui/presentations/shared/widgets/shimmering/values/type_list.dart';
import 'package:plastik_ui/values/colors.dart';

class ReportTransaction extends StatefulWidget {
  static String routeName = '/reporttransactions';

  @override
  _ReportTransactionState createState() => _ReportTransactionState();
}

class _ReportTransactionState extends State<ReportTransaction> {
  _ReportTransactionState() {
    _scrollController = ScrollController();
    _reportTransactionsBloc =
        ReportTransactionsBloc(reportService: getIt<ReportService>());
  }

  ScrollController _scrollController;
  ReportTransactionsBloc _reportTransactionsBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReportTransactionsState>(
      stream: _reportTransactionsBloc.reportTransactions,
      builder:
          (BuildContext ctx, AsyncSnapshot<ReportTransactionsState> snapshot) {
        void fetchTransactions(BuildContext context, bool paging) {
          _reportTransactionsBloc.fetchingTransactions(
              paging: paging,
              onError: (String message) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              });
        }

        Function _showFilterModal(BuildContext context) {
          return () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext ctx) {
                return Container(
                  height: 280,
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: InputPickerDateTime(
                          label: 'Tanggal Mulai',
                          onChanged: (DateTime datetime) =>
                              snapshot.data.onChangeStartAt(datetime),
                          value:
                              snapshot.hasData ? snapshot.data.startAt : null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: InputPickerDateTime(
                          label: 'Tanggal Berakhir',
                          onChanged: (DateTime datetime) =>
                              snapshot.data.onChangeEndAt(datetime),
                          value: snapshot.hasData ? snapshot.data.endAt : null,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: RaisedButton(
                          color: PRIMARY_COLOR,
                          child: Text(
                            'Cari',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            fetchTransactions(context, false);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          };
        }

        return Scaffold(
          appBar: AppBar(
              title: Text(
                'Transaksi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: _showFilterModal(context),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              backgroundColor: WHITE_COLOR),
          body: Builder(
            builder: (BuildContext ctx) {
              _scrollController.addListener(() {
                if (_scrollController.position.extentBefore <
                        _scrollController.position.extentAfter &&
                    _scrollController.position.extentAfter < 100 &&
                    snapshot.hasData &&
                    !snapshot.data.loading) {
                  Future.delayed(Duration(milliseconds: 500),
                      () => fetchTransactions(ctx, true));
                }
              });

              if (!snapshot.hasData && !snapshot.hasError) {
                fetchTransactions(ctx, false);
              }

              if (!snapshot.hasData && !snapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: FluttonShimmering.list(
                    count: 10,
                    countLine: 5,
                    heightLine: 6,
                    heightAvatar: 48,
                    lastWidthLine: 28,
                    widthAvatar: 48,
                    widthLine: MediaQuery.of(context).size.width * 0.75,
                    typeList: FluttonShimmeringTypeList.ITEM_AVATAR,
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.hasData ? snapshot.data.count : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ItemTransaction(
                    onTap: () {
                      Navigator.of(ctx).push(
                        MaterialPageRoute(
                          builder: (_) => ReportTransactionDetail(
                              id: snapshot.data.transactions[index].id),
                          settings: RouteSettings(
                            name: ReportTransactionDetail.routeName,
                          ),
                        ),
                      );
                    },
                    amount: snapshot.data.transactions[index].amount,
                    createdAt: snapshot.data.transactions[index].createdAt,
                    typeName: snapshot.data.transactions[index].typeName,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
