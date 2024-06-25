import 'dart:async';

extension UnWarp<T> on Future<T?> {
  Future<T> unwarp() =>
      then((value) => value != null ? Future<T>.value(value) : Future.value());
}
