class BaseBloc<T> {
  Stream<List<T>> _results = Stream.empty();
  Stream<List<T>> get results => _results;
}
