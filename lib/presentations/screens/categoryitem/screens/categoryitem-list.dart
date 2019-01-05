import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/screens/categoryitem-form.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/states/categoryitem-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/error-notification.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class CategoryItemList extends StatefulWidget {
  static String routeName = '/category';

  @override
  _CategoryItemListState createState() => _CategoryItemListState();
}

class _CategoryItemListState extends State<CategoryItemList> {
  _CategoryItemListState() {
    categoryItemListState =
        CategoryItemListState(itemService: getIt<ItemService>());
  }

  @override
  void dispose() {
    categoryItemListState.removeListener(() {});
    super.dispose();
  }

  CategoryItemListState categoryItemListState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Kategori Barang'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          void fetchingItems() {
            categoryItemListState.fetchingItems(onError: (String massage) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(massage),
              ));
            });
          }

          fetchingItems();
          return ScopedModel<CategoryItemListState>(
              model: categoryItemListState,
              child: ScopedModelDescendant<CategoryItemListState>(
                builder: (BuildContext contect, Widget child,
                    CategoryItemListState model) {
                  if (model.loading && !model.error) {
                    return LoadingIndicator();
                  }

                  if (!model.loading && model.count == 0 && !model.error) {
                    return NotFound();
                  }

                  if (!model.loading && model.error) {
                    return ErrorNotification(
                      onRetry: fetchingItems,
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.count,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemRightArrow(
                        label: model.items[index].name,
                        onPress: () {
                          Navigator.of(contect).push(MaterialPageRoute(
                              builder: (_) => CategoryItemForm(),
                              settings: RouteSettings(
                                name: CategoryItemForm.routeName,
                              )));
                        },
                      );
                      //Text(model.items[index].name);
                    },
                  );
                },
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CategoryItemForm(),
              settings: RouteSettings(
                name: CategoryItemForm.routeName,
              ),
            ),
          );
        },
      ),
    );
  }
}
