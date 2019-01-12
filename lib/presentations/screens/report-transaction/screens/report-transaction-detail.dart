import 'package:flutter/material.dart';
import 'package:plastik_ui/app.dart';
import 'package:plastik_ui/domains/report/model/dto/transaction-detail.dart';
import 'package:plastik_ui/domains/report/service/report.dart';
import 'package:plastik_ui/helpers/datetime/datetime.dart';
import 'package:plastik_ui/helpers/number/format-currency.dart';
import 'package:plastik_ui/presentations/screens/report-transaction/blocs/report-transaction-detail.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:plastik_ui/presentations/shared/widgets/shimmering/values/type_list.dart';
import 'package:plastik_ui/values/colors.dart';

class ReportTransactionDetail extends StatefulWidget {
  static String routeName = '/reporttranasction/detail';

  ReportTransactionDetail({
    this.id,
  });

  final String id;

  @override
  _ReportTransactionDetailState createState() =>
      _ReportTransactionDetailState();
}

class _ReportTransactionDetailState extends State<ReportTransactionDetail> {
  DateTimeCustom _dateTimeCustom;
  ReportTransactionDetailBloc _reportTransactionDetailBloc;

  _ReportTransactionDetailState() {
    _dateTimeCustom = DateTimeCustomImplementation();
    _reportTransactionDetailBloc =
        ReportTransactionDetailBloc(reportService: getIt<ReportService>());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaksi',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<TransactionDetail>(
        stream: _reportTransactionDetailBloc.transactionDetail,
        builder: (BuildContext ctx, AsyncSnapshot<TransactionDetail> snapshot) {
          void fetchDetailTransaction() {
            _reportTransactionDetailBloc.fetchReportTransaction(
              id: widget.id,
              onError: (String message) {
                Scaffold.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            );
          }

          fetchDetailTransaction();

          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(12),
              child: FluttonShimmering.list(
                count: 1,
                countLine: 5,
                widthLine: MediaQuery.of(context).size.width * 0.95,
                lastWidthLine: 28,
                heightLine: 6,
                typeList: FluttonShimmeringTypeList.ITEM,
              ),
            );
          }

          if (snapshot.hasError) {
            return ErrorNotification(
              onRetry: fetchDetailTransaction,
            );
          }

          return SingleChildScrollView(
            primary: true,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      snapshot.data.typeName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        snapshot.data.type == 'TRANSACTION_IN' ||
                                snapshot.data.type == 'TRANSACTION_OUT'
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.type == 'TRANSACTION_IN' ||
                                              snapshot.data.type ==
                                                  'TRANSACTION_OUT'
                                          ? 'Penjual    : '
                                          : 'Penyuplai  : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(snapshot.data.supplierName ??
                                        snapshot.data.sellerName),
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Total         : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(formatCurrency(snapshot.data.amount)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Tanggal    : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(snapshot.data.createdAt),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      'Detil',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.details.length + 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext ctx, int index) {
                        if (index == 0) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(ctx).size.width * 0.28,
                                  child: Text(
                                    'Nama',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(ctx).size.width * 0.28,
                                  child: Text(
                                    'Jumlah',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(ctx).size.width * 0.28,
                                  child: Text(
                                    'Harga',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(ctx).size.width * 0.28,
                                child: Text(
                                    snapshot.data.details[index - 1].itemName),
                              ),
                              Container(
                                width: MediaQuery.of(ctx).size.width * 0.28,
                                child: Text(snapshot.data.details[index - 1].qty
                                    .toString()),
                              ),
                              Container(
                                width: MediaQuery.of(ctx).size.width * 0.28,
                                child: Text(formatCurrency(
                                    snapshot.data.details[index - 1].amount)),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
