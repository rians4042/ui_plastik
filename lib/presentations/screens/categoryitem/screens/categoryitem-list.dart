import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/screens/categoryitem-form.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/states/categoryitem-list.dart';
import 'package:plastik_ui/presentations/shared/widgets/item-right-arrow.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/not-found.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryItemList extends StatelessWidget {
  CategoryItemListState categoryItemListState;

  static String routeName = '/category';

  CategoryItemList() {
    categoryItemListState = CategoryItemListState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Barang'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          categoryItemListState.fetchingItems(onError: (String massage) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(massage),
            ));
          });
          return ScopedModel<CategoryItemListState>(
              model: categoryItemListState,
              child: ScopedModelDescendant<CategoryItemListState>(
                builder: (BuildContext contect, Widget child,
                    CategoryItemListState model) {
                  if (model.loading == true) {
                    return LoadingIndicator();
                  }
                  if (model.loading == false && model.count == 0) {
                    return NotFound();
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
