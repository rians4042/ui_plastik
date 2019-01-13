import 'package:flutter/material.dart';
import 'package:Recet/domains/actor/service/actor.dart';
import 'package:Recet/presentations/screens/supplier/blocs/supplier-list.dart';
import 'package:Recet/presentations/screens/supplier/screens/supplier-form.dart';
import 'package:Recet/presentations/screens/supplier/states/supplier-list.dart';
import 'package:Recet/presentations/shared/widgets/error-notification.dart';
import 'package:Recet/presentations/shared/widgets/item-right-arrow.dart';
import 'package:Recet/presentations/shared/widgets/loading-indicator.dart';
import 'package:Recet/presentations/shared/widgets/not-found.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/values/type_list.dart';
import 'package:Recet/values/colors.dart';
import 'package:Recet/app.dart';

class SupplierList extends StatefulWidget {
  static String routeName = '/supplier';

  @override
  State<StatefulWidget> createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  SupplierListBloc _supplierListBloc;

  _SupplierListState() {
    _supplierListBloc = SupplierListBloc(actorService: getIt<ActorService>());
  }

  @override
  void dispose() {
    _supplierListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penyuplai'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchSuppliers() {
            _supplierListBloc.fetchSuppliers(onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            });
          }

          fetchSuppliers();
          return StreamBuilder<SupplierListState>(
            stream: _supplierListBloc.suppliers,
            builder:
                (BuildContext ctx, AsyncSnapshot<SupplierListState> snapshot) {
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
              }

              // show page empty data whenever data is zero and no error on there
              if (snapshot.hasData &&
                  snapshot.data.count == 0 &&
                  !snapshot.hasError) {
                return NotFound();
              }

              if (snapshot.hasError) {
                return ErrorNotification(
                  onRetry: fetchSuppliers,
                );
              }

              return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data.count : 0,
                itemBuilder: (BuildContext ctx, int index) {
                  return ItemRightArrow(
                    label: snapshot.data.suppliers[index].name,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SupplierForm(
                                id: snapshot.data.suppliers[index].id,
                              ),
                          settings: RouteSettings(
                            name: SupplierForm.routeName,
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
              builder: (_) => SupplierForm(),
              settings: RouteSettings(
                name: SupplierForm.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
