import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/itemcategory/api/itemcategoryapi.dart';
import 'package:plastik_ui/domain/itemcategory/model/itemcategoryapimodel.dart';
import 'package:plastik_ui/domain/itemcategory/service/itemcategoryservice.dart';

class ItemCategory extends StatefulWidget {
  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  ItemCategoryAPIInterface _api;
  ItemCategoryServiceInterface _service;

  /**
   * constructor called, whenever the 
   * itemcategory created a new instance
   */

  _ItemCategoryState() {
    /**
   * implement service and api
   */
    _api = ItemCategoryAPI();
    _service = ItemCategoryService(api: _api);
  }

  /**
   * state property inner class item category
   */

  bool _isLoading = false;
  bool _isError = false;
  List<ItemCategoryAPIModel> _itemCategories = [];

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

      // calling service (for the best part, logical business throw it into service layer)
      List<ItemCategoryAPIModel> itemCategories =
          await _service.getItemCategories();

      // if success then set item to the state
      setState(() {
        _isLoading = false;
        _isError = false;
        _itemCategories = itemCategories;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Category"),
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
            itemCount: _itemCategories.length,
            itemBuilder: (BuildContext ctx, int index) {
              return new Container(
                padding: EdgeInsets.all(2.0),
                child: Card(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      _itemCategories[index].name,
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    new Text(
                      _itemCategories[index].id,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
                    new Text(_itemCategories[index].createdaAt,
                        style: TextStyle(fontSize: 12.0, color: Colors.black)),
                  ],
                )),
              );
            },
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
