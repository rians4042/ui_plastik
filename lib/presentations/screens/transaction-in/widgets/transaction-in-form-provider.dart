import 'package:flutter/material.dart';
import 'package:Recet/presentations/screens/transaction-in/blocs/transaction-in-form-bloc.dart';

class TransactionInFormProvider extends InheritedWidget {
  final Widget child;
  final TransactionInFormBloc transactionInFormBloc;

  TransactionInFormProvider({
    @required this.child,
    @required this.transactionInFormBloc,
  });

  static TransactionInFormProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TransactionInFormProvider);
  }

  @override
  bool updateShouldNotify(TransactionInFormProvider oldWidget) {
    return oldWidget.transactionInFormBloc != transactionInFormBloc;
  }
}
