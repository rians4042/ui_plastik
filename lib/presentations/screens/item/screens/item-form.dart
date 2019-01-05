import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/item/model/dto/item.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/presentations/screens/item/states/item-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/presentations/shared/widgets/dropdown-custom.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class ItemForm extends StatefulWidget {
  ItemForm({this.id});

  final String id;
  static String routeName = '/item/form';

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  _ItemFormState() {
    _itemFormState = ItemFormState(itemService: getIt<ItemService>());
    _nameController = TextEditingController();
  }

  ItemFormState _itemFormState;
  TextEditingController _nameController;

  @override
  void dispose() {
    _itemFormState.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Barang'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchInitialData() {
            _itemFormState.getInitialData(
              widget.id,
              onSuccess: (Item item) {
                if (item != null) {
                  _nameController.text = item.name;
                }
              },
              onError: (String message) {
                Scaffold.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
            );
          }

          void deleteItem() {
            showDialog(
              context: ctx,
              builder: (BuildContext context) => AlertDialog(
                    title: Text('Hapus'),
                    content: Text('Apakah anda yakin menghapus data ini ?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Tidak'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      FlatButton(
                        child: Text('Hapus'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _itemFormState.deleteItem(widget.id, onSuccess: () {
                            Navigator.of(ctx).pop();
                          }, onError: (String message) {
                            Scaffold.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
            );
          }

          fetchInitialData();
          return ScopedModel<ItemFormState>(
            model: _itemFormState,
            child: ScopedModelDescendant<ItemFormState>(
              builder:
                  (BuildContext context, Widget child, ItemFormState model) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: TextField(
                          controller: _nameController,
                          onChanged: (String name) => model.onChangeName(name),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.0,
                                color: GREY_COLOR,
                              ),
                            ),
                            labelText: 'Nama',
                            enabled: !model.loading,
                            errorText: model.errName,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: DropdownCustom<String>(
                          label: 'Pilih Kategori',
                          loading: model.loadingItemCategories,
                          initialData: '',
                          items: model.itemCategories
                              .map(
                                (itemCategory) => DropdownMenuItem(
                                      child: Text(itemCategory.name),
                                      value: itemCategory.id,
                                    ),
                              )
                              .toList(),
                          onChanged: (String id) {
                            model.onChangeCategoryId(id);
                          },
                          value: model.itemCategoryId,
                          isExpanded: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: DropdownCustom<String>(
                          label: 'Pilih Satuan',
                          loading: model.loadingItemUnits,
                          initialData: '',
                          items: model.itemUnits
                              .map(
                                (unit) => DropdownMenuItem(
                                      child: Text(unit.name),
                                      value: unit.id,
                                    ),
                              )
                              .toList(),
                          onChanged: (String id) {
                            model.onChangeUnitId(id);
                          },
                          value: model.unitId,
                          isExpanded: true,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ButtonLoading(
                          loading: model.loading,
                          disabled: model.errName != null ||
                              (model.name == null || model.name == ''),
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                              color: WHITE_COLOR,
                            ),
                          ),
                          color: PRIMARY_COLOR,
                          onPressed: () {
                            model.addOrUpdateItems(widget.id, onSuccess: () {
                              Navigator.of(ctx).pop();
                            }, onError: (String message) {
                              Scaffold.of(ctx).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    message,
                                    style: TextStyle(
                                      color: WHITE_COLOR,
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      widget.id == null
                          ? Container()
                          : Container(
                              width: double.infinity,
                              child: ButtonLoading(
                                loading: model.loading,
                                disabled: model.errName != null ||
                                    (model.name == null || model.name == ''),
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: WHITE_COLOR,
                                  ),
                                ),
                                color: RED_COLOR,
                                onPressed: deleteItem,
                              ),
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
