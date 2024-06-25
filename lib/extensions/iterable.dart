extension Flatten<T extends Object> on Iterable<T> {
  Iterable<T> flatten() {
    Iterable<T> _flatten(Iterable<T> list) sync* {
      for (var item in list) {
        if (item is List<T>) {
          yield* _flatten(item);
        } else {
          yield item;
        }
      }
    }
    return _flatten(this);
  }
}
