import 'package:Recet/domains/report/model/dto/transaction.dart';

class ReportTransactionsState {
  bool _loading;
  bool _hasNext;
  String _endAt;
  String _startAt;
  Map<int, List<Transaction>> _transactions;

  bool get loading => _loading;
  bool get hasNext => _hasNext;
  int get page => _transactions.length == 0 ? 1 : _transactions.length;
  int get count {
    int _count = 0;
    _transactions.forEach((_, transaction) => _count += transaction.length);

    return _count;
  }

  DateTime get startAt =>
      _startAt != null ? DateTime.parse(_startAt) : _startAt;
  DateTime get endAt => _endAt != null ? DateTime.parse(_endAt) : _endAt;
  List<Transaction> get transactions {
    List<Transaction> results = [];
    _transactions.forEach((_, transaction) => results.addAll(transaction));

    return results;
  }

  ReportTransactionsState.empty() {
    _hasNext = true;
    _loading = false;
    _transactions = {};
  }

  void beginFetchTransactions() {
    _loading = true;
  }

  void successFetchTransactions(bool paging, List<Transaction> transactions) {
    _loading = false;
    if (paging == true) {
      _transactions[page] = transactions;
    } else {
      _transactions = {page: transactions};
    }

    if (transactions.length > 0 || !paging) {
      _hasNext = true;
    } else {
      _hasNext = false;
    }
  }

  void onChangeStartAt(DateTime startAt) {
    _startAt = startAt.toString();
  }

  void onChangeEndAt(DateTime endAt) {
    _endAt = endAt.toString();
  }
}
