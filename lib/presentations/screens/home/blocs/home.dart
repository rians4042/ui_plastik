import 'package:Recet/presentations/shared/blocs/base-bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements BaseBloc {
  BehaviorSubject<int> _statesTabIndex;

  Stream<int> get index => _statesTabIndex.stream;
  Sink<int> get changeIndex => _statesTabIndex.sink;

  HomeBloc() {
    _statesTabIndex = BehaviorSubject<int>(seedValue: 0);
  }

  @override
  void dispose() {
    _statesTabIndex?.close();
  }
}
