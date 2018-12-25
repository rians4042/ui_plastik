import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/itemcategory/api/itemcategoryapi.dart';
import 'package:plastik_ui/domain/itemcategory/model/itemcategorymodel.dart';
import 'package:plastik_ui/domain/itemcategory/service/itemcategoryservice.dart';

class ItemCategory extends StatefulWidget {
  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  ItemCategoryAPIInterface _api;
  ItemCategoryServiceInterface _service;

  _ItemCategoryState() {
    _api = ItemCategoryAPI();
    _service = ItemCategoryService();
  }

  bool _isLoading = false;
  bool _isError = false;
  List<ItemCategoryAPIModel> _itemcategories = [];

  @override
  void initState() {
    super.initState();
    _getItemCategories();
  }

  void _getItemCategories() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<ItemCategoryAPIModel> itemcategory =
          await _service.getItemCategory();

      setState(() {
        _isLoading = false;
        _isError = false;
        _itemcategories = _itemcategories;
      });
    } catch (e) {
      setState(() {
        _isError = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Builder(
        builder: (BuildContext ctx) {
          if (_isLoading == true) {
            return Container(
              alignment: Alignment(0.0, 0.0),
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _itemcategories.length,
            itemBuilder: (BuildContext ctx, int index) {
              return new Container(
                padding: EdgeInsets.all(2.0),
                child: Card(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      _itemcategories[index].title,
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    new Text(
                      _itemcategories[index].body,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
                  ],
                )),
              );
            },
          );
        },
      ),
    );
  }
}
