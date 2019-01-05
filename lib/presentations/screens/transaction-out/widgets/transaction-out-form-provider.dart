import 'package:flutter/material.dart';
import 'package:plastik_ui/presentations/screens/transaction-out/blocs/transaction-out-form-bloc.dart';

class TransactionOutFormProvider extends InheritedWidget {
  final Widget child;
  final TransactionOutFormBloc transactionOutFormBloc;

  TransactionOutFormProvider({
    @required this.child,
    @required this.transactionOutFormBloc,
  });

  static TransactionOutFormProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TransactionOutFormProvider);
  }

  @override
  bool updateShouldNotify(TransactionOutFormProvider oldWidget) {
    return oldWidget.transactionOutFormBloc != transactionOutFormBloc;
  }
}
