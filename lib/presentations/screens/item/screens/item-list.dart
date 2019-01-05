import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/presentations/screens/item/screens/item-form.dart';
import 'package:plastik_ui/presentations/screens/item/states/item-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/app.dart';

class ItemList extends StatefulWidget {
  static String routeName = '/item';
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  ItemListState _itemListState;

  _ItemListState() {
    _itemListState = ItemListState(itemService: getIt<ItemService>());
  }

  @override
  void dispose() {
    _itemListState.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Barang'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchingInitialData() {
            _itemListState.fetchingItems(onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            });
          }

          fetchingInitialData();
          return ScopedModel<ItemListState>(
            model: _itemListState,
            child: ScopedModelDescendant<ItemListState>(
              builder: (BuildContext ctx, Widget child, ItemListState model) {
                if (model.loading && !model.error) {
                  return LoadingIndicator();
                }

                if (!model.loading && model.error) {
                  return ErrorNotification(
                    onRetry: fetchingInitialData,
                  );
                }

                if (!model.loading && model.count == 0 && !model.error) {
                  return NotFound();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.count,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ItemRightArrow(
                      label: model.items[index].name,
                      onPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ItemForm(id: model.items[index].id),
                            settings: RouteSettings(
                              name: ItemForm.routeName,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ItemForm(),
              settings: RouteSettings(
                name: ItemForm.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
