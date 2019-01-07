import 'package:flutter/material.dart';
import 'package:plastik_ui/domains/item/model/dto/item-category.dart';
import 'package:plastik_ui/domains/item/service/item.dart';
import 'package:plastik_ui/presentations/screens/categoryitem/states/categoryitem-form.dart';
import 'package:plastik_ui/presentations/shared/widgets/button-loading.dart';
import 'package:plastik_ui/presentations/shared/widgets/loading-indicator.dart';
import 'package:plastik_ui/values/colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plastik_ui/app.dart';

class CategoryItemForm extends StatefulWidget {
  CategoryItemForm({this.id});

  final String id;
  static String routeName = '/category/form';

  @override
  _CategoryItemFormState createState() => _CategoryItemFormState();
}

class _CategoryItemFormState extends State<CategoryItemForm> {
  _CategoryItemFormState() {
    _categoryItemFormState =
        CategoryItemFormState(itemService: getIt<ItemService>());
    _nameController = TextEditingController();
  }

  CategoryItemFormState _categoryItemFormState;
  TextEditingController _nameController;

  @override
  void dispose() {
    _categoryItemFormState.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulir Kategori'),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          void fetchInitialData() {
            _categoryItemFormState.getInitialData(widget.id,
                onSuccess: (ItemCategory itemCategory) {
              if (itemCategory != null) {
                _nameController.text = itemCategory.name;
              }
            }, onError: (String message) {
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text(message),
              ));
            });
          }

          void deleteCategory() {
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
                            _categoryItemFormState.deleteCategory(widget.id,
                                onSuccess: () {
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
                    ));
          }

          fetchInitialData();

          return ScopedModel<CategoryItemFormState>(
            model: _categoryItemFormState,
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
                            model.addOrUpdateCategories(widget.id,
                                onSuccess: () {
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
                                onPressed: deleteCategory,
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
} //
