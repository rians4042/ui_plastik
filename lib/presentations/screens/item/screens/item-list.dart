import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plastik_ui/presentations/screens/item/states/item-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';

class ItemList extends StatelessWidget {
  ItemListState itemListState;

  static String routeName = '/item';

  ItemList() {
    itemListState = ItemListState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          itemListState.fetchingItems(onError: (String message) {
            Scaffold.of(ctx).showSnackBar(SnackBar(
              content: Text(message),
            ));
          });
          return ScopedModel<ItemListState>(
            model: itemListState,
            child: ScopedModelDescendant<ItemListState>(
              builder: (BuildContext ctx, Widget child, ItemListState model) {
                if (model.loading == true) {
                  return LoadingIndicator();
                }

                if (model.loading == false && model.count == 0) {
                  return NotFound();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.count,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ItemRightArrow(
                      label: model.items[index].name,
                      onPress: () {},
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'add',
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
