typedef T ParserType<T, TT>(TT body);

T parserRawRequest<T, TT>(ParserType<T, TT> parser, TT body) {
  return parser(body);
}
