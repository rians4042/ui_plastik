import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/item/api/itemapi.dart';
import 'package:plastik_ui/domain/item/model/itemmodel.dart';
import 'package:plastik_ui/domain/item/service/itemservice.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  ItemAPIInterface _api;
  ItemServiceInterface _service;

  /**
   * constructor called, whenever the 
   * itemcategory created a new instance
   */

  _ItemState() {
    /**
   * implement service and api
   */
    _api = ItemAPI();
    _service = ItemService(api: _api);
  }

  /**
   * state property inner class item category
   */

  bool _isLoading = false;
  bool _isError = false;
  List<ItemAPIModel> _item = [];

  @override
  void initState() {
    super.initState();
    _getItem();
  }

  void _getItem() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // calling service (for the best part, logical business throw it into service layer)
      List<ItemAPIModel> item = await _service.getItems();

      // if success then set item to the state
      setState(() {
        _isLoading = false;
        _isError = false;
        _item = item;
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
        title: Text("Item"),
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
            itemCount: _item.length,
            itemBuilder: (BuildContext ctx, int index) {
              return new Container(
                padding: EdgeInsets.all(2.0),
                child: Card(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      _item[index].name,
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    new Text(
                      _item[index].id,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    ),
                    new Text(_item[index].createdaAt,
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