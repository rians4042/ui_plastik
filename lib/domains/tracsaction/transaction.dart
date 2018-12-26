import 'package:flutter/material.dart';
import 'package:plastik_ui/domain/tracsaction/api/transactionapi.dart';
import 'package:plastik_ui/domain/tracsaction/model/transactionmodel.dart';
import 'package:plastik_ui/domain/tracsaction/service/transactionservice.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TransactionAPIInterface _api;
  TransactionServiceInterface _service;

  TransactionState() {
    _api = TransactionAPI();
    _service = TransactionService();
  }

  bool _isLoading = false;
  bool _isError = false;
  List<TransactionAPIModel> _transactions = [];

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }

  void _getTransactions() async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<TransactionAPIModel> itemcategory = await _service.getTransaction();

      setState(() {
        _isLoading = false;
        _isError = false;
        _transactions = _transactions;
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
        title: Text("Transaction"),
      ),
    );
  }
}
