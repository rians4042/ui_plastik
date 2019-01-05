import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/model/dto/item-unit.dart';
import 'package:plastik_ui/presentations/screens/item/states/item-forn.dart';

import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/presentations/shared/widgets/update-button.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemForm extends StatelessWidget {
  ItemFormState itemFormState;

  static String routeName = '/item/form';

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
                      DropdownButton(
                        value: model.itemCategoryId,
                        items: model.itemCategories
                            .map((ItemCategory itemCategory) =>
                                DropdownMenuItem<String>(
                                  value: itemCategory.id,
                                  child: Text(itemCategory.name),
                                ))
                            .toList(),
                        onChanged: (String value) {
                          model.onChangeCategory(value);
                        },
                      ),
                      DropdownButton(
                        value: model.unitId,
                        items: model.itemUnit
                            .map(
                                (ItemUnit itemUnit) => DropdownMenuItem<String>(
                                      value: itemUnit.id,
                                      child: Text(itemUnit.name),
                                    ))
                            .toList(),
                        onChanged: (String value) {
                          model.onChangeUnit(value);
                        },
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
}
