import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/states/categoryitem-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class CategoryItemForm extends StatelessWidget {
  CategoryItemFormState categoryItemFormState;

  static String routeName = '/category/form';

  CategoryItemForm() {
    categoryItemFormState = CategoryItemFormState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Category'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ScopedModel<CategoryItemFormState>(
            model: categoryItemFormState,
            child: ScopedModelDescendant<CategoryItemFormState>(
              builder: (BuildContext context, Widget child,
                  CategoryItemFormState model) {
                if (model.loading == true) {
                  return LoadingIndicator();
                }
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        //onChange:,
                        decoration: InputDecoration(labelText: 'Nama Kategori'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
