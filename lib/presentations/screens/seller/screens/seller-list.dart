import 'package:flutter/material.dart';
import 'package:Recet/domains/actor/service/actor.dart';
import 'package:Recet/presentations/screens/seller/blocs/seller-list.dart';
import 'package:Recet/presentations/screens/seller/screens/seller-form.dart';
import 'package:Recet/presentations/screens/seller/states/seller-list.dart';
import 'package:Recet/presentations/shared/widgets/error-notification.dart';
import 'package:Recet/presentations/shared/widgets/item-right-arrow.dart';
import 'package:Recet/presentations/shared/widgets/loading-indicator.dart';
import 'package:Recet/presentations/shared/widgets/not-found.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/shimmering.dart';
import 'package:Recet/presentations/shared/widgets/shimmering/values/type_list.dart';
import 'package:Recet/values/colors.dart';
import 'package:Recet/app.dart';

class SellerList extends StatefulWidget {
  static String routeName = '/seller';

  @override
  State<StatefulWidget> createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {
  SellerListBloc _sellerListBloc;

  _SellerListState() {
    _sellerListBloc = SellerListBloc(
      actorService: getIt<ActorService>(),
    );
  }

  @override
  void dispose() {
    _sellerListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjual'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchSellers() {
            _sellerListBloc.fetchSellers(onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            });
          }

          fetchSellers();
          return StreamBuilder<SellerListState>(
            stream: _sellerListBloc.sellers,
            builder:
                (BuildContext ctx, AsyncSnapshot<SellerListState> snapshot) {
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
                  onRetry: fetchSellers,
                );
              }

              return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data.count : 0,
                itemBuilder: (BuildContext ctx, int index) {
                  return ItemRightArrow(
                    label: snapshot.data.sellers[index].name,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SellerForm(
                                id: snapshot.data.sellers[index].id,
                              ),
                          settings: RouteSettings(
                            name: SellerForm.routeName,
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
              builder: (_) => SellerForm(),
              settings: RouteSettings(
                name: SellerForm.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
