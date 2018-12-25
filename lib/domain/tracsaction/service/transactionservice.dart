import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:plastik_ui/domain/tracsaction/api/transactionapi.dart';
import 'package:plastik_ui/domain/tracsaction/model/transactionmodel.dart';

abstract class TransactionServiceInterface {
  Future<List<TransactionAPIModel>> getTransaction();
}

class TransactionService extends TransactionServiceInterface {
  TransactionAPIInterface api;

  TransactionService({
    @required this.api,
  });

  @override
  Future<List<TransactionAPIModel>> getTransaction() async {
    final http.Response response = await api.getTransaction();
    if (response?.body != null) {
      final body = jsonDecode(response.body);
      List<TransactionAPIModel> result = [];

      for (int i = 0; i < body.lenght; i++) {
        final TransactionAPIModel temp = TransactionAPIModel(
            sellerId: body[i]['sellerid'],
            note: body[i]['note'],
            details: body[i]['details'],
            images: body[i]['images']);

        result.add(temp);
      }
      return result;
    }
    return null;
  }
}
