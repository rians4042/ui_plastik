import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/item/states/item-forn.dart';
import 'package:plastik_ui/presentations/shared/screens/base-screen.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/update.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemForm extends StatelessWidget implements BaseScreen {
  ItemFormState itemFormState;

  ItemForm() {
    itemFormState = ItemFormState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tambah Item'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return ScopedModel<ItemFormState>(
            model: itemFormState,
            child: ScopedModelDescendant<ItemFormState>(
              builder:
                  (BuildContext context, Widget child, ItemFormState model) {
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
                        onChanged: (String name) {
                          model.onChangeName(name);
                        },
                        decoration: InputDecoration(labelText: 'Nama Barang'
                            //labelText: model.name,
                            //errorText: model.errorName),
                            ),
                      ),
                      UpdateWidget(),
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

  @override
  String getRouteName() {
    return '/';
  }
}

class Update {}
