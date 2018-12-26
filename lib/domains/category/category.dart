import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/category/api/categoryapi.dart';
import 'package:plastik_ui/domain/category/mode/categorymodel.dart';
import 'package:plastik_ui/domain/category/service/categoryservice.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryAPIInterface _api;
  CategoryServiceInterface _service;

  _CategoryState() {
    _api = CategoryAPI();
    _service = CategoryService();
  }

  bool _isLoading = false;
  bool _isError = false;
  List<CategoryAPIModel> _category = [];

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  void _getCategory() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<CategoryAPIModel> category = await _service.getCategory();

      setState(() {
        _isLoading = false;
        _isError = false;
        _category = category;
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
            itemCount: _category.length,
            itemBuilder: (BuildContext ctx, int index) {
              return new Container(
                padding: EdgeInsets.all(2.0),
                child: Card(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      _category[index].title,
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                    ),
                    new Text(
                      _category[index].body,
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
