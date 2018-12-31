import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/supplier/blocs/supplier-list.dart';
import 'package:plastik_ui/presentations/screens/supplier/screens/supplier-form.dart';
import 'package:plastik_ui/presentations/screens/supplier/states/supplier-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:plastik_ui/values/colors.dart';

class SupplierList extends StatefulWidget {
  static String routerName = '/supplier';

  @override
  State<StatefulWidget> createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList> {
  SupplierListBloc _supplierListBloc;

  _SupplierListState() {
    _supplierListBloc = SupplierListBloc();
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
              bool hasError = snapshot.error != null;

              // show loading when the loading state is true and error is false
              if (snapshot.hasData && snapshot.data.loading && !hasError) {
                return LoadingIndicator();
              }

              // show page empty data whenever data is zero and no error on there
              if (snapshot.hasData && snapshot.data.count == 0 && !hasError) {
                return NotFound();
              }

              if (hasError) {
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
